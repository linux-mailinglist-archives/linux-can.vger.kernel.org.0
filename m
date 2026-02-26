Return-Path: <linux-can+bounces-6647-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Bh+KiRXoGkNigQAu9opvQ
	(envelope-from <linux-can+bounces-6647-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 15:22:28 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 110031A76E1
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D4231C0D6B
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248A6361677;
	Thu, 26 Feb 2026 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZkrkJtf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k1Qp1yBq"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B13A1A27
	for <linux-can@vger.kernel.org>; Thu, 26 Feb 2026 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115122; cv=none; b=oGoGb1MgcpHkl9ROqz7EagiHlGKJZPt406JRsL32f2OBvBiT6B17E4C/q8XOcOPTjRyJbPKAmgn7uQ0Q2s1tAkxNVsTHxWU+0N601TrgVXwjXMbIvjk+97IINuZML28dE9MXva3mqii3wNEDXLXCzrJeMeoIoSmJf4icTH0/Y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115122; c=relaxed/simple;
	bh=Zdzhg1VvkirEy/QlmDB+qd7VezDSX0wFVid7IBJpags=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG8Z3xXwx2xM5cnHjB601x5BRLfEJHKODU8+C88ykiKSXTYrnr2luDbrUmNqnDpOKh0PdAuaFiqb90lKLatS+3POOkeJQYLCiHHC9xUiBIVt/pNVCw5kjcLT7rb//Www0rKupVor9kZjfC4oV9FLk7oteYKRxr1mWInXMdE4lxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZkrkJtf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k1Qp1yBq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772115119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eOpbM9M15EuxWd+IWwH8daRCpwecjuZ8you3Hh2pT5s=;
	b=IZkrkJtfMjXar6/lo/Wbeu8FwoJHOZqhl9Unz7Dpo/yD7bcR6ztgjo/x4GvHwwiRqwPqOi
	lm5RU2so7EPJeVAjdTQSax7S0ezD14Dm1kGkcvHgFPXafDKVJtBoJF0ngTVbjibnnW/m80
	nO0YazlNy46vTtFZxo6Eu6LSPVP0pYY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-lbfD0eGeO96QequmnYyMpw-1; Thu, 26 Feb 2026 09:11:58 -0500
X-MC-Unique: lbfD0eGeO96QequmnYyMpw-1
X-Mimecast-MFC-AGG-ID: lbfD0eGeO96QequmnYyMpw_1772115117
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b936b6b4473so10044566b.0
        for <linux-can@vger.kernel.org>; Thu, 26 Feb 2026 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772115117; x=1772719917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOpbM9M15EuxWd+IWwH8daRCpwecjuZ8you3Hh2pT5s=;
        b=k1Qp1yBqIuEP5fPslOD629AHx2CsaNs8C3XOaXJqPVQH6Nq8Hmnh6rXPO+M2Z2oTPM
         f8VLdFDpOZLssWvKP5afd3ZV/E4WJ75a/p427fSfNe+1f0VpKUB7fDuYZXbQBQonxqZa
         A5lgjhrJy5X5G2lqo8GyN05MK1z9dgMWradsj1SxZwol0ucvWaRgy965ohc6SHfH7955
         6I49YkBITrwDSmxcQHBOzgfMzoDCxlwpdOve69Kjs1BUv/JUQM3JhQKaWxWdhneVf+jX
         LdIkJNKsDLL61Eb9pRoYLHW3+YXW6/f9s0eln9lekBscflEUJq5WGpqHVDbLhZtMOa0f
         o4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115117; x=1772719917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOpbM9M15EuxWd+IWwH8daRCpwecjuZ8you3Hh2pT5s=;
        b=k9CQKfZRVSRlHb5fCQXkgKdQTmAI5r/GALDQ6Zf6tF7nrx9TsnOLNrw/jFhpZYSExs
         IWcYp4TAlN0u3uXy47BTh953Ri0yOZkc+ynI/oqUPa6L2QEb9c7RbxFy/fdS+oL8nAGP
         oZYizdv1nJS6gHPxhiO6tmJy37OOBV6sAOaeP5hzwU9qQQOqCLljuhjBkI8cH/k3SVan
         MNYxLLsGDNCScYcX9FpAjxq7kAU+Q/PHJbzJhqC/L3ulFGxdThRg+5Pa7uppYmmqmhYu
         Qx4ynTScY3H2J3hYhXNwIR8YmezFwQiZe8q9FKG/CjArZr2rSlOXZVQQs9rLF09BgxnI
         05WA==
X-Forwarded-Encrypted: i=1; AJvYcCV+oFM/bQ2PL43sCioQFu+CzABETT5NB91hjSZ6Pq603JcXwfDJIHdJIW2BA8gvoN91m7p6LvvZmiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqq//iVnt2XpPgByJZQfvTsXC/h7OxEM3rGouUiH4OxY81NbIr
	tVf1kNnZFDL6bz/xW6bT19Mevd7s5k8haB9HXYzJSbGNmhpO0RDvlXFHPDfdQZ8nbwU4NY6x7mh
	O8NXZkzKMqs5FL1iL+IG1y376tu/Aaroy7Dbe9o9R2PYUvdf9f0wnmRXjrS+vkA==
X-Gm-Gg: ATEYQzzCmV4Psh9irr4zKgS0q04Ny0HiH7yTbB/ujq+J+1usCSUHUhSS4lnuzfLg8m2
	g7P6+2nlJJ2Ux4NUw2SBaL3zw/dxMgda0ldmllk8EmfZngW1Zu7YJJUy+JrvEuDd2t0lAkDfGTe
	GfZR9b/I456lUfvzpXqYL2FJKG3+zZHqeJUxvtG5fSyXGR5JDVzBgclbFqSHofFMrxuI4FpJuZn
	oHPOUVY/ltLV7IStQSRgtNOCubkPhzy1cX+hxpXWrSYGOOU3SxBdRvFVd5jCur69yRu+0wmciWs
	K8Zj8IjItI0I7rtT+5SUarO3r3VrW2bsQUoKOV/Oa4XRSlzYvEs0Sps20n5umtxiGD8LMPeZKkT
	9D40T7ty8NdNbqRWmRDhDr1wErThzcQIBI+gABgFPVZZwzQ==
X-Received: by 2002:a17:907:7fac:b0:b8f:a85c:95c5 with SMTP id a640c23a62f3a-b9356754254mr185007366b.37.1772115116988;
        Thu, 26 Feb 2026 06:11:56 -0800 (PST)
X-Received: by 2002:a17:907:7fac:b0:b8f:a85c:95c5 with SMTP id a640c23a62f3a-b9356754254mr185004466b.37.1772115116395;
        Thu, 26 Feb 2026 06:11:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ab137a1sm63798266b.2.2026.02.26.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:11:55 -0800 (PST)
Date: Thu, 26 Feb 2026 09:11:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
Message-ID: <20260226090956-mutt-send-email-mst@kernel.org>
References: <aZRB7Reu/D6HvRcb@fedora>
 <76036b0d-fe61-4d19-a209-65e1a790c107@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76036b0d-fe61-4d19-a209-65e1a790c107@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6647-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 110031A76E1
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 03:08:28PM +0100, Harald Mommer wrote:
> Hello Matias,
> 
> On 2/17/26 11:24, Matias Ezequiel Vara Larsen wrote:
> 
> > +static int virtio_can_probe(struct virtio_device *vdev)
> > +{
> ...
> > +	priv->rpkt = devm_kzalloc(&vdev->dev, priv->rpkt_len *
> > +						priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free,
> > +						GFP_KERNEL);
> ...
> We're here clearly beyond column 80 with something which is not a string or a comment. Elsewhere we are also sometimes beyond column 80 but then only 1 or 2 characters which may or may not be acceptable by the kernel community. No idea. You may re-check the formatting.

it's relaxed recently - does not make sense to uglify code to fit
in 80 chars.

> Besides formatting:
> 
> I compared your actual v10 of the virtio CAN driver against my last v5 and and I saw nothing in your code which may cause a problem. Only learned doing the review this way that at some corners my old v5 code was not this bug free as I thought when I saw some changes. Nothing serious because in some "not expected to happen" corner case code paths but anyway I'll occasionally have to take over some of your changes into an internal project repository here.
> 
> We will see whether this virtio CAN device will be accepted in some near future for integration in the mainline kernel...
> 
> Regards
> Harald


