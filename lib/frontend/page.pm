package frontend::page;
use Dancer ':syntax';
use Dancer::Plugin::DBIC qw(schema resultset rset);
use Dancer::Plugin::Feed;

prefix '/page';

get '/' => sub {
	redirect '/page/id/' 
					 . config->{ROOT_PAGE_ID};
};

get '/id/:id' => sub {
		my $page = _page_by_id(params->{id});
		if(!$page) {
			redirect '/404'
		}
		else {
			redirect uri_for($page->link);
		}
};

get '/api/recent' => sub {
	set serializer => "mutable";

	my $page_rs = _page_recent();
	my @ps = $page_rs->all;
  
	my @pages = map {
		author		 => config->{SITE_AUTHOR},
		created_at => $_->created_at->ymd,
		id         => $_->id,
		parent_id  => $_->parent_id,
		slug       => $_->slug,
		link			 => uri_for($_->link)->as_string,
		summary		 => $_->auto_summary,
		title			 => $_->title,
	}, @ps;

	return {pages => \@pages}
};

get '/api/:id' => sub {
	set serializer => "mutable";

	my $p = _page_by_id(params->{id});
	if (!$p) {
		send_error("Cannot retrieve page with id " . params->{id});
		return;
	}
	my $page = {
		author		 => config->{SITE_AUTHOR},
		created_at => $p->created_at->ymd,
		id         => $p->id,
		parent_id  => $p->parent_id,
		slug       => $p->slug,
		link       => uri_for($p->link)->as_string,
		summary		 => $p->auto_summary,
		title			 => $p->title,
	};
	return {page => $page};
};

get '/feed/:format' =>sub {
	my $page_rs  = _page_recent();
	my @ps = $page_rs->all;
	my $format = params->{format};
	if(uc $format ne 'RSS' && uc $format ne 'ATOM') {
		send_error("Bad feed format. RSS or Atom.");
		return
	}
	my $feed = create_feed( 
    format => params->{format}, #Feed format (RSS or Atom) 
    title => 'Recent pages on charlieharvey.org.uk',
		description => "The latest blog posts from my website, charlieharvey.org.uk",
		image => {
			title => "charlieharvey.org.uk pages feed", 
			width => 240,
			height => 45,
			url    => "/graphics/minilogo.png",
			link   => uri_for("/comments"),
		},
    entries => [ map { 
			title   => $_->title || "Untitled", 
			link    => uri_for($_->link),
			author  => config->{SITE_AUTHOR},
			summary => $_->auto_summary,
			issued  => $_->updated_at,
		}, @ps ], #makes collection of feed entries
  );
  return $feed;

};

get '/:slug/?' => sub {
	my $slug = params->{slug};
	$slug =~ s{\/$}{}; 
	my $page = _page_by_slug($slug);
	
	if(!$page) {
		redirect '/404';
		return
	}
	
	my @ancestors = $page->ancestors;
	my @recent_children = $page->recent_children;

	if ($page->is_root) {
		template 'page/root', { 
			page => $page, 
			title => $page->title,
			own_url => uri_for($page->link)->as_string,
			parent_url => uri_for('page/0')->as_string,
			ancestors => \@ancestors,
			recent_children => \@recent_children,
			description => "Charlie Harvey&#8217;s blog. With articles about tech, cider, vegan food and computer science. Amongst other things.",
		}; # index page, use index teplate
	}
	elsif ($page->is_cover) {
		template 'page/cover', { 
			page => $page, 
			title => $page->title,
			own_url => uri_for($page->link)->as_string,
			parent_url => uri_for($page->parent->link)->as_string,
			ancestors => \@ancestors,
			recent_children => \@recent_children,
			description => $page->auto_summary,
		}; # cover page
	}
	else {
		template 'page/view', { 
			page => $page, 
			title => $page->title,
			own_url => uri_for($page->link)->as_string,
			parent_url => uri_for($page->parent->link)->as_string,
			ancestors => \@ancestors,
			description => $page->auto_summary,
		}; # normal page view
	}
};


get '/:slug/archive/?' => sub {
	redirect '/page/' . params->{slug} . '/archive/1'
};

get '/:slug/archive/:page/?' => sub {
	my $slug = params->{slug};
	my $page_offset = params->{page};
	$page_offset = 1 unless ($page_offset && $page_offset =~ /\d+/ && $page_offset > 0);
	$slug =~ s{\/$}{}; 
	my $page = _page_by_slug($slug);
	unless ($page && $page->is_cover) {
		redirect '/404';
		return;
	}

	my $page_rs = _page_archive($page->id);
	my $page_obj = $page_rs->page($page_offset);
	my @pages = $page_obj->all;
	template 'page/archive', { 
			page => $page, 
			own_url => uri_for($page->link)->as_string,
			parent_url => uri_for($page->parent->link)->as_string,
			pages => \@pages,
			pager => $page_obj->pager, 
			page_offset => $page_offset,
			title => $page->title 
							 . " archive, page " 
							 . $page_offset,
			description => "Archive of posts about " 
										 . $page->title
										 . " (page $page_offset)"
										
	}; # archive view
};

##

sub _page_archive {
    my ($id) = @_;
    my $schema = schema 'frontend';
    my $results = $schema->resultset('Page')->search({ 
				parent_id => { '=', $id } ,
				is_live => {'=', 1},
			},
      { 
					order_by => { -desc => 'id' },
    });
    return $results;
}

sub _page_recent {
    my ($id) = @_;
    my $schema = schema 'frontend';
    my $results = $schema->resultset('Page')->search({ 
				is_live => {'=', 1},
			},
      { 
					order_by => { -desc => 'id' },
					rows => config->{RESULTS_PER_PAGE},
    });
    return $results;
}
sub _page_by_slug {
	my $slug = shift;
  my $schema = schema 'frontend';
	my $page = $schema->resultset('Page')->find({slug => $slug});
	return $page;
}

sub _page_by_id {
	my $id = shift;
  my $schema = schema 'frontend';
	my $page = $schema->resultset('Page')->find({id => $id});
	return $page;
}