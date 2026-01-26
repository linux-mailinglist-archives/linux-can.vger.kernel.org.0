Return-Path: <linux-can+bounces-6306-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOFXH8A9d2mMdQEAu9opvQ
	(envelope-from <linux-can+bounces-6306-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 11:11:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D7F86780
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 11:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D9093001CE5
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC50313547;
	Mon, 26 Jan 2026 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaE1s/MI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPKY2tvj"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A22BEC5E
	for <linux-can@vger.kernel.org>; Mon, 26 Jan 2026 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422016; cv=none; b=pP9E24H1POv2I5ksGK8SB+O6158ue/jV0l95PMBpf9YpAnzhPvqAgXvRkDoSh9FDBCre7OQwtiEDUhXM+R9ynRj/HDKDfzMklMPwh6VmKzWp8XmV+qFuX9MjWigIiH+b2yJCgow07KMbE3J21rqUpHvRi1uiAlZcK8z4W2Uvj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422016; c=relaxed/simple;
	bh=RwbCROst0SrKoPI0Mz/RhGJ6cgMIVH0PkBXsjkD/Qrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICM2ePANYncYabOieWIJt5/pt7XFAJr7JwvPRTtn8fHk6mUCKolQHufDGgtaJH32YmMKYaB+PbvRmKDgfQUyqTPpA4omDobCF/7qav76h539NJp/E6ID6KdeOHqbazMXSxj/h1pHW6mUJvVkZNkMpxv9gEpaOjpaNx7QiuM/TXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaE1s/MI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPKY2tvj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769422014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGZ7zVWK6KG4OaKzcOGu+si3YSRlswA4cevBUVUMjg8=;
	b=iaE1s/MISKnaxmjXC76DJs1Ko7kCWdVzgSNCjk7JH62Bx70UX3SEcn9Zyq+xXZeOX8P2mY
	JBX6mLbi9YSep+jDUYi4+rDGHGyM2ZdFw/SbfA9uMiHTAsR9++ijN8gp5GjTCaK2QqEYPa
	HYR/BQUhcyx0dXo2kyVyG5R2hZ0m6u8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-l9kDqIQEPNSXIFDpim-Pkw-1; Mon, 26 Jan 2026 05:06:42 -0500
X-MC-Unique: l9kDqIQEPNSXIFDpim-Pkw-1
X-Mimecast-MFC-AGG-ID: l9kDqIQEPNSXIFDpim-Pkw_1769422002
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee3dd7fc8so46800405e9.3
        for <linux-can@vger.kernel.org>; Mon, 26 Jan 2026 02:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769422001; x=1770026801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGZ7zVWK6KG4OaKzcOGu+si3YSRlswA4cevBUVUMjg8=;
        b=tPKY2tvjho1iJSmU0RAdzlmPLmjKvZd5X4d3i4axDaClwtOgMPevU+i6x3L+cYZBFH
         AJOtnin95LiDrODl96xIrL0F1sbkVf+HXRaxrXx5RwCT9MNCbNZpGXrJer6uEdVz9s+A
         WIMEHvLiuK+TQuKCY5JOCX76hcBB0XpW+Nz4wQmXGnIWoXrXZndNl47IxLh0S3ZHE9UH
         Y8oimSs7RkpBI/L26wp94rhwGAphzuSvLf5l644E48rt5wVHq6CAar+MtLguuNz6E0pC
         hyFmK+CIjSLv3Qz5l1KgMlgqQ2gjD6J/Qnbd4BkOoryucHsX7A+Ao/66FziRvHzqLdlp
         9pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422001; x=1770026801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGZ7zVWK6KG4OaKzcOGu+si3YSRlswA4cevBUVUMjg8=;
        b=RGiV+bdyJDcRhVLQguIiFYQrcrooqh/jYUZEqU1BriRPj67OTlURId86fVOkXKlx00
         Dt/LZqLTC9FYmy5hObSYBjef6SAIfnAseDj4zEHVbYr2XzbX+dmHd26XdwORdKT4XMo1
         uV6t0nDYGxxuOFFAo2VXNa4Y0/YSOUGIStzoA0fONE7xnAKngUkyhgwSZdsDs1LhXlL5
         dwt8g/X+YeUKBONaJ+hZ/g4Ha267xy3YAt5WklDl6FDaZLFuNFsz0WWG6bjETNaB9KHH
         nuMznQQwBFmbAQuu+6d4BIw+HPcvejBwejlrws32D0tdF++wwihtffv4iKElia1NWJy6
         78WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSsbhVs0CMQAC9F8MhbuTf4ysom5qjhA+WxALI3bNw8dDDcrvQtbfunUMOOURnn2sJkSW7BcYxYVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztbDFHtQD6xU/bhrsR30YNWcc33AVRpkUd1kdauKmrc207Qiq9
	LciRMnUDhsBCJyfbeIhSoCezV0D8veJk5VlO4NiFINZfDAi2SUf0T+/HtJL87PkAAsq7C9HcDo/
	RVz65c6I+Br3H3ht5jUEyVqrPJp45EvgDrqV0D0d16/bW+L6IbJSUWB8fBJffRP/z32Jkwg==
X-Gm-Gg: AZuq6aIVvjacvqC/HEhk4iqUeAaBEBJPKkCa3zRkUwQuB+fgsoq3aMGNRBQRU4UIsWl
	1jaYL3XyPXq5PU356B9rx9dfiEQ2up5bQh4iVBhW60wi/tvEjI1KsDs2KrbFZa5gvxYmNn1aMRd
	Y09gWcd4kfe7LolLqCCEJy0HS1QGEBdEaidUW/DNFWsevMLKyDfAcE7+UdwEo3ou6d7f0PdUfN1
	GQ5u/7/FrLAlAU3jEfFegxbtVoXdDSxxPRVNM+7pxMBKkqDIWqBk+XarPmWVndLpYaa93PnKFA0
	NakXzkEhyovpU7kqneH/R1+bwH672ig/rqBn4rGA4KcZtkrETzTMXrH4fd17/s9DLoBd71NDkYl
	n7ao=
X-Received: by 2002:a05:600c:8b0e:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4805ce4def9mr74286385e9.16.1769422001239;
        Mon, 26 Jan 2026 02:06:41 -0800 (PST)
X-Received: by 2002:a05:600c:8b0e:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4805ce4def9mr74286025e9.16.1769422000817;
        Mon, 26 Jan 2026 02:06:40 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85206fsm266170605e9.6.2026.01.26.02.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:06:40 -0800 (PST)
Date: Mon, 26 Jan 2026 11:06:38 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v8] can: virtio: Add virtio CAN driver
Message-ID: <aXc8rhN8SvmOFbJ0@fedora>
References: <aW/D8kiFu666wiuD@fedora>
 <aXYkWO0ShTsrjP1R@bywater>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXYkWO0ShTsrjP1R@bywater>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6306-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mvaralar@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8D7F86780
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 03:10:32PM +0100, Francesco Valla wrote:
> Hi Matias,
> 
> If an additional version is foreseen, consider dropping some more
> note-like comments, as in future they might become dangling.
> 

Yes! I am planing to remove some comments and send v9. I was not
completely sure which ones. Also, I was thinking to set myself as a
maintainer in case Harald is busy.

> E.g.:
> 
> On Tue, Jan 20, 2026 at 07:05:38PM +0100, Matias Ezequiel Vara Larsen wrote:
> 
> [...]
> 
> > +
> > +/* Poll TX used queue for sent CAN messages
> > + * See https://wiki.linuxfoundation.org/networking/napi function
> > + * int (*poll)(struct napi_struct *napi, int budget);
> > + */
> > +static int virtio_can_tx_poll(struct napi_struct *napi, int quota)
> > +{
> 
> [...]
> 
> > +/* See m_can_poll() / m_can_handle_state_errors() m_can_handle_state_change() */
> > +static int virtio_can_handle_busoff(struct net_device *dev)
> > +{
> 
> [...]
> 
> > +/* Poll RX used queue for received CAN messages
> > + * See https://wiki.linuxfoundation.org/networking/napi function
> > + * int (*poll)(struct napi_struct *napi, int budget);
> > + * Important: "The networking subsystem promises that poll() will not be
> > + * invoked simultaneously (for the same napi_struct) on multiple processors"
> > + */
> > +static int virtio_can_rx_poll(struct napi_struct *napi, int quota)
> > +{
> > +
> 
> [...]
> 
> > +/* Compare with m_can.c/m_can_suspend(), virtio_net.c/virtnet_freeze() and
> > + * virtio_card.c/virtsnd_freeze()
> > + */
> > +static int __maybe_unused virtio_can_freeze(struct virtio_device *vdev)
> > +{
> 
> [...]
> > +
> > +/* Compare with m_can.c/m_can_resume(), virtio_net.c/virtnet_restore() and
> > + * virtio_card.c/virtsnd_restore()
> > + */
> > +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
> > +{
> 
> 
> With this (maybe negligible) note considered: 
> 
> Reviewed-by: Francesco Valla <francesco@valla.it>
> Tested-by: Francesco Valla <francesco@valla.it>
> 

Thanks Francesco!

Matias


