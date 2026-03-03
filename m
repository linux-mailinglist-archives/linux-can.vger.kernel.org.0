Return-Path: <linux-can+bounces-6811-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKBuF8hHpmkkNgAAu9opvQ
	(envelope-from <linux-can+bounces-6811-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Mar 2026 03:30:32 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66F1E80A1
	for <lists+linux-can@lfdr.de>; Tue, 03 Mar 2026 03:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C1EC30300E4
	for <lists+linux-can@lfdr.de>; Tue,  3 Mar 2026 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B7375F83;
	Tue,  3 Mar 2026 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JfPMs15Z"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E400374E69
	for <linux-can@vger.kernel.org>; Tue,  3 Mar 2026 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505025; cv=pass; b=R2Yvqyf4IF2IbEEKJ9yDlC9JoGjOArHXtZWyDiPaWQyMd/nlGWXXLYpKmLW2jrHJqOqFE/IYnKcCJw0fwOH5JxQLjjEascYHjnMNB4wC8xCQ3lSshkFoJyYGOWJbL1vcNv0J1sBErVnIt5GIGytEyhPZO0wBA+xybwVvUlQuWAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505025; c=relaxed/simple;
	bh=dpQSmzkUM5eywQT8MkIz9dqIAPHwbz822026FlJmJ4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAekG9Z0L7XwqYCJojJAPRYvBiLuxuNg28uGKRWyllVY4suZpWAJlvJEa4x3ToBGuceJizERGJb8d70EGNXG/PLbjGWyhij4yykbUxGVFu98i4xJ1EJYAkrki9Kkgq7VQb6pclDpS4VKcTjBsHN9CGxyVBF/t0DyTzG3kPdc45Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JfPMs15Z; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70bc5b4e86so1955026a12.0
        for <linux-can@vger.kernel.org>; Mon, 02 Mar 2026 18:30:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772505024; cv=none;
        d=google.com; s=arc-20240605;
        b=VFuQCnIjrs4nlUXSKGz5VeTeiExBKGg6tcxa2q+PDdbEA3oRPkxVH3Scrm7NbnVWkr
         QT9oYiaEWilrstDkhd7MPVgXUTxVKjVx+6EJyWikNePsI68aZLlLwO8+qrjBDf1wHyqc
         ZcSzxGZudOK0jkMULtsLwuItebbN+deqsEcbXDtxu1evWVAmIxHOJT9YT2H+5FyjxfJT
         /QNXuZ1pmGdBHZtNF3Lhi4neDs2ZUFDtxbuWPt6CHTG9hSKaJ30O4+rRN7YfO9IkEAqR
         Ip3UcwbCzKw2AUJk+oTtPmTHhe3iXUg7ljw6VI1vxeSoJDvcrr1yajwDZvDg+Q9Q50je
         zE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=;
        fh=cNgqxGgClDs0HX0CXFwk7S6FXYEga5g4Vfcnr9NzZS8=;
        b=j8NcsX3EpA7x7kC4rMLbDxIxv9domRRLlNc1WF0yrSkrS/M/WfZSAKquVy8YxwtPA9
         IsCvd6J8MEtrzCwFcErPcokwvWxhHp4xZybgYCqAaAfBI6pmALl8nJtC6fnOh13gpPWr
         nQWY2rgj1Yt7UxI124gXWbThkpSzAVCW16+fVmdBExrQZbKu5e96RvajMcXSPkm7tK4O
         DWAVKu4eAhV4eX+bZ/EG1rONzg4qjrNmWZpE1mrDMzu67LokklMIgle/cb5Q+o9ZU1ah
         BnXFE9rzum9iur3i+NmkmRQcdh0adNFe50Bz46zKpSebQxJeZ+o/jZiL0RjdSBri0Pg8
         dipQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772505024; x=1773109824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=;
        b=JfPMs15ZCu5uQlmdqQusmBhN/hCtjzE2ILqtdhvnIFAYHSV1FHjmSyA1arRjcsqd4i
         Z4zhEf/tJOotLdNVozbOOjxhBlRwJk71hprzA2SYVvUIKNvz8c/GjcFp3BL7vDklngvO
         zl4V4Vp916TZAWDuaMm3M9LB/UUzTTI4PNa8ZN0UQKnn5dtnNA/PDX+I+seNTfdQA7FQ
         eAeF4P/7MyBqU3rFB/xabPpQJ0tZLgdAdrccAFYA5DSO631fAvLOUoY97xGiqrBBqUXo
         Z1tmyiODc/zF//4CcHZRtYJNPYA1OChITkK1DJK96ljrZqSQHtTgNfr5zJ5nJo1M7dd7
         ac4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505024; x=1773109824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKlMqpEd7YBdXym1IpYpN4BFku3eaQLOirqfkrIT+SY=;
        b=D41AmsK3r+bFybj9y90tznKDGkEg1kclIBrvXsq5xgUHa0iNKxJaqSIWhCmTuqzmmC
         YEWGBlTeMgBh0tWMESCGMAWswD7Owhd2+Gxb7gISIJJrHw66lUFxqfbtI+IRxBNcv8vD
         GXNn2Uq4eBkCHNvuZ3M904Ti0eRcKdyk4+sjw2ZD5oCiVz07LWugemhnNN63aSk6v4eK
         HIW54lKkpMFUs1nxAPLUgsJ3cqQMY9z/zkKkQqwzLwi8dXyI/ATshn+JFa7WvxclKMEL
         n+5Avxa073vyu8Sj0r327EcCz7Uxc5W+oMRCKNgVV5zaQ6y/0ZW5/9vWSSRvG/5GZ2me
         FZUw==
X-Forwarded-Encrypted: i=1; AJvYcCXZmDwDrLFgcgnmOs3cKwFz7w1MeQ9BzTvDC9atJl9vzplDuGjKFZ6KgCewv13yqULBFkYNT3ybBqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYaXoYxVqsUivseK2xKmnetcYe8mtyvHC2hggibLnlu7Dyoth
	rrcXLv2iHwyFrp3sGTttjshLr7FzaXzlZz1NXICU2TWFHIT7NWZ3zXlNxr41fG1f5bgYwr7ekID
	htWxE5XncV91egs/FBg8d8/T2IINUr5tN56ALhS3E
X-Gm-Gg: ATEYQzxbdWBmENie6IWIHKASLqBD0VtmTAjXpOD+IidkrIGeB66F5fA58kNQ3FHJt+L
	ROut5ojdtug6NJDH66F2F/be6dMQ0C4XqS+pmMwmbXZVefVOzOZl7JwZoTHNuGugC1r1wXx7+//
	dtU9c85hHlWm92XurUz1UgKsQYuv+FSVQ1WnE59H0QsarxyDdjfhYWz20uLYYHuBluqBMf4TXbh
	BWeyyzlnGh2ja1egHCGW0D63vCKx2CunhZFBs/7L/+4Aq6OLeaKy3mVsXO9GxL9HSVafChlPcwv
	41ecLD4Vv/PjkEzjAw==
X-Received: by 2002:a17:903:244a:b0:2ae:56f8:747b with SMTP id
 d9443c01a7336-2ae56f8786cmr37920855ad.57.1772505023451; Mon, 02 Mar 2026
 18:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org> <20260302-iino-u64-v2-105-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-105-e5388800dae0@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Mar 2026 21:30:10 -0500
X-Gm-Features: AaiRm53tOqTCLn9NgvLgqwCOFo4xSyksjolr8ucn59RQ44Ck0r7mzGeRmSI5U0c
Message-ID: <CAHC9VhSHj7qc-tKxEN45bkfr+Dha59ihzOGiCO2WDYTYoB-LeA@mail.gmail.com>
Subject: Re: [PATCH v2 105/110] security: replace PRIino with %llu/%llx format strings
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org, audit@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CC66F1E80A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
	TAGGED_FROM(0.00)[bounces-6811-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[171];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 3:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> Now that i_ino is u64 and the PRIino format macro has been removed,
> replace all uses in security with the concrete format strings.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/apparmor/apparmorfs.c       |  4 ++--
>  security/integrity/integrity_audit.c |  2 +-
>  security/ipe/audit.c                 |  2 +-
>  security/lsm_audit.c                 | 10 +++++-----
>  security/selinux/hooks.c             | 10 +++++-----
>  security/smack/smack_lsm.c           | 12 ++++++------
>  6 files changed, 20 insertions(+), 20 deletions(-)

For the LSM framework and SELinux changes ...

Acked-by: Paul Moore <paul@paul-moore.com> (LSM/SELinux)

--=20
paul-moore.com

