Return-Path: <linux-can+bounces-7752-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZRCfBFsdIGpSwAAAu9opvQ
	(envelope-from <linux-can+bounces-7752-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 14:26:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9923C637794
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 14:26:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=nwkGD7Xd;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7752-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7752-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D59933059A6F
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542DA3D3D01;
	Wed,  3 Jun 2026 12:25:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C03D3D05;
	Wed,  3 Jun 2026 12:25:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489540; cv=none; b=qC+ZOj+CrJUxWpuVhseKd3Db3EFF66fOGUS14l1OeMKZEMMjR+IoynIGQS1SlaK+8HrLXjT+Ee/ChpGuBts1YWvAHjwdcmnmjOSEGnzcpc8WzhXTcQ12pwoYYSyHYmmXPfdFN6l97UAfK3+P792zFR3bvXvzikE3dXnP7RXKuME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489540; c=relaxed/simple;
	bh=Wanlt/GPXopJFl9TTndxtLl8x8MIMHRTtcn6HGUMGlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjipB2EYDopaFQ3afQ2At/yTBhWQE1J10lB0MkpcLRloY4zuUYKD1WtZ1A8xeawcs6yZFyAQ1YB0UlA9VtfW3aM5Dmi3VZAzKrS5xb2B4szoTL9s3TwvJrynqvk1vaqdSA5awcsKINtFpMy1W9nkA+T0ryg2kfFAaIcTPZbWFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nwkGD7Xd; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9+B58Y7Q5TKWf9GB44d3GfMo3/Zbw6nJeZknsy07vvw=; b=nwkGD7XduSEbBAQ5wCQl9lz3Dc
	FBWEXyLxcEokaQTvSJ7EpmL1vluLp/cu+X54Ps1somy7Gn02IVz4DwDmvdyKh/CJF3vgl9slDHzN8
	MNkBkZoDd7jAB1bk5HffSHgE3Uow1rL/zKt5M6634Ku+Mksf0bzptFqHeH+taImTarfsnnPd8gm0T
	sG+wdC0Aap4Zh94o4wA3/UA1XipgZ/tRla9JDOLvFnlTdrDlCaxPIdn0uggQMHnmLn2MQGrppkcFO
	DIEjx9SwlH2oThd7hY1oX0dpCjG9BpjHabAP3pKB+rkFpctrQpzbj7GqibKuw+iMqBTAR+WcPC1a9
	+gdwAqnQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUkf1-003jP4-0j;
	Wed, 03 Jun 2026 12:25:27 +0000
Date: Wed, 3 Jun 2026 05:25:22 -0700
From: Breno Leitao <leitao@debian.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] can: isotp: convert to getsockopt_iter
Message-ID: <aiAcRJ8TBjWhlKhQ@gmail.com>
References: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
 <20260507-getsock_two_can-v1-2-3c2ae9edfadc@debian.org>
 <14d3ad71-ade2-4d2b-8a67-b0fda3eef2b7@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d3ad71-ade2-4d2b-8a67-b0fda3eef2b7@hartkopp.net>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7752-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:robin@protonic.nl,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9923C637794

On Mon, May 11, 2026 at 09:05:07AM +0200, Oliver Hartkopp wrote:
> 
> 
> On 07.05.26 11:34, Breno Leitao wrote:
> > Convert CAN ISO-TP socket's getsockopt implementation to use the new
> > getsockopt_iter callback with sockopt_t.
> > 
> > Key changes:
> > - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> > - Use opt->optlen for buffer length (input) and returned size (output)
> > - Use copy_to_iter() instead of put_user()/copy_to_user()
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   net/can/isotp.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/can/isotp.c b/net/can/isotp.c
> > index c48b4a818297e..1c33f09fbd338 100644
> > --- a/net/can/isotp.c
> > +++ b/net/can/isotp.c
> > @@ -1500,7 +1500,7 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
> >   }
> >   static int isotp_getsockopt(struct socket *sock, int level, int optname,
> > -			    char __user *optval, int __user *optlen)
> > +			    sockopt_t *opt)
> >   {
> >   	struct sock *sk = sock->sk;
> >   	struct isotp_sock *so = isotp_sk(sk);
> > @@ -1509,8 +1509,7 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
> >   	if (level != SOL_CAN_ISOTP)
> >   		return -EINVAL;
> > -	if (get_user(len, optlen))
> > -		return -EFAULT;
> > +	len = opt->optlen;
> >   	if (len < 0)
> >   		return -EINVAL;
> > @@ -1544,9 +1543,8 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
> >   		return -ENOPROTOOPT;
> >   	}
> > -	if (put_user(len, optlen))
> > -		return -EFAULT;
> > -	if (copy_to_user(optval, val, len))
> > +	opt->optlen = len;
> > +	if (copy_to_iter(val, len, &opt->iter_out) != len)
> >   		return -EFAULT;
> >   	return 0;
> >   }
> > @@ -1718,7 +1716,7 @@ static const struct proto_ops isotp_ops = {
> >   	.listen = sock_no_listen,
> >   	.shutdown = sock_no_shutdown,
> >   	.setsockopt = isotp_setsockopt,
> > -	.getsockopt = isotp_getsockopt,
> > +	.getsockopt_iter = isotp_getsockopt,
> >   	.sendmsg = isotp_sendmsg,
> >   	.recvmsg = isotp_recvmsg,
> >   	.mmap = sock_no_mmap,
> > 
> 
> Same pattern as in net/can/raw.c that had slipped in via net-next last time
> ;-)
> 
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Thanks Breno!

Thanks for the review!

I haven't seen this on linux-next yet. Please let me know if there is any
update that is expected from my side.

--breno

