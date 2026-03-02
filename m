Return-Path: <linux-can+bounces-6686-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ2BIyazpWlaEgAAu9opvQ
	(envelope-from <linux-can+bounces-6686-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:56:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B981DC3E9
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04C4030675AF
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406DB41B37F;
	Mon,  2 Mar 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQb+rTsN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvU/vct1"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962541B351
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466742; cv=none; b=GEZ0PcXiREXgoqM4CTSB58HtUyRH4EBi91CwJTlSmQHEAVKDj0mCSzLRGh7+3lU3gT9XwYUkFMFtC+nCbqllWQqs/8J1K1b068kN27wATmuOEs1SMxZZbc5ICho5aJHhCl41jrcvzJuhzCezLncgZqXIQCQ5xHvE09dOE0/gPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466742; c=relaxed/simple;
	bh=hpnlOqrcE6XKQCbvfZC/Jw2+6G9P7VjT8fcJZ6bj9hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQFlWXLAiZsWlRl/lmye3LSwBOLFzUOqT/ViF8ECN/t5GKtyQcn8XbknCIrqcAl1ATQ9wYxIFQov5sWVZ+lCyzD+BPuPPIH9yVije9VGzXycLdW38y1TUxzZ4Hu5QphWdXvaFWdw4k6hJHjpH1BNY7hULPWDR0EpZLdBLz4yXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQb+rTsN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvU/vct1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772466739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CH9mL5pbMrwDtlONtIMgJdUZf3F53m9y7sOyrOwP3i8=;
	b=WQb+rTsNIkM0kdKzWL51AjDhHiqlgTw6kMhf4scEGvDoR9Lczz1dnvqlHZHYE/vl/GOwrw
	njEuXH4hT6QApaZJjzLiuaV+xa9D/f2owtK5dOE4a0WEY/oxM/bdni7fACrSkrcHaEU2tc
	UEEwtqfkTUtUvpLXpiXbrUC5QVoc5AQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-rrx-Dq2WM6a5tx-XUC3G0w-1; Mon, 02 Mar 2026 10:52:18 -0500
X-MC-Unique: rrx-Dq2WM6a5tx-XUC3G0w-1
X-Mimecast-MFC-AGG-ID: rrx-Dq2WM6a5tx-XUC3G0w_1772466737
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836c819456so31938795e9.3
        for <linux-can@vger.kernel.org>; Mon, 02 Mar 2026 07:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772466737; x=1773071537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CH9mL5pbMrwDtlONtIMgJdUZf3F53m9y7sOyrOwP3i8=;
        b=YvU/vct1xUuLzN5uqPejW2qIKgPJzCPYf+n3o6GP4ngK3gXNlkxHNC4OPjekMYpyIS
         4H8Q7mB3dG0qcYyQciDZXxNz5MfT1sQlLL+yYSWxCHT11BgIrgQ2D2qVZovfDDzZNGxF
         5Z+5qoupzZP1N0yebt89E0ftYawejbiZwzX8h8NZdXPqar9pCnbW3TjVOXJ0iwFiBfik
         BtTBjV6H63H/ob7SUJ/QI4szHEsolSDFtGqxRVDsIvq49PqduUlbgX9ds/l7VoEbnKDw
         NB3wBLouxIKFFpXRJDZY6C3SQJXsmwg72mcC+WecBOuz7Uddg+lwdlHaNDe5601+fSIJ
         jEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466737; x=1773071537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH9mL5pbMrwDtlONtIMgJdUZf3F53m9y7sOyrOwP3i8=;
        b=p4OOmwTkNw3DD9giBdDL1O+1StEZHehh392a2IHh1DIqNf9XreAgvJiD8eU+4OHECo
         ggFEujmN5GQ9KE5+z5LAmxiFoSS91VtV51il/CdhioZ/bM7iEDjHYzQZSrIbCECJYVCh
         ixjJiyhyUlNibRP9hzxqcj1+Mf6620uI0dXjMZ1sMX3uwGKXKrWFDdqiKejjez5A7xUr
         5uVxrbzB1hqkrXQXpbtkqRSQ2Y0U/d8fa+gvXQUr2ny+qiy6MP+ai2LQjBDbrO3WJ2lQ
         ZP2BzJP6XmcE0nP27JMe1eftqqtbaa0C79MkUmJTPM9DDzBjLo41Ru/lKaztcgiWQ5DB
         dc9g==
X-Forwarded-Encrypted: i=1; AJvYcCU5IRRhjAMS4UYhaBkiDzzn/iDnhUJwLMTdeC22NwSXGwf7Dq7gH4Y4cduar9crQZYZLbuaZSD9CNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyddAbp9ibVMMyt4xPyG+AgPQowmMLsW8Sijdhx2WZPxX6iPr9a
	bjab6YNTEJbhJeKy7AR+9ql2/WOSRXWsSGCVN8qazFiRItvAA3Ge6UJmIWQfQZ+8C/Uy4jxSZ/r
	aucUsDIAs0uWfOjDLFzi7Ghk+rj0soPEm7RL/geWcYFDaSXz4rncJfyjZdJkByg==
X-Gm-Gg: ATEYQzxrtrjFD0OQ6rUQTCb4qXTHaCcjxrjVePycDu7vsVR1FdWaMjQqdXdm+Z63O0I
	3e251Zadca19MCNneW1Qnpc343mY9nzUqA+THQXhUUd7bSg8vaKhzdkErAzz21upszH2nj2+uCX
	rUBJM4u6BUgYqToSna4Zv01+JCJSBRJlTgQZ1K229GdBxqgjETGO7A+nWNvVHul3Rf0DcC5dNJN
	gtpeBVxIeC7F8nrCfi+FyvTw+CE+0Ne/IHKAJM93P8PNMZ6VUW5G897wHyBZ6xT9Fi2nOnNfL0r
	8WV5+4c7iIt2yM5lgCBruteFTk50CNBO0n2x5VgzMkezcIBbCtOU70pqC3CXYrg0RmUQLbTY/68
	Q8CrWudHPixRWToA=
X-Received: by 2002:a05:600c:64c7:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-483c9bc55a1mr224120425e9.7.1772466736850;
        Mon, 02 Mar 2026 07:52:16 -0800 (PST)
X-Received: by 2002:a05:600c:64c7:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-483c9bc55a1mr224120045e9.7.1772466736375;
        Mon, 02 Mar 2026 07:52:16 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm336188245e9.4.2026.03.02.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:52:15 -0800 (PST)
Date: Mon, 2 Mar 2026 16:52:13 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
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
	Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
Message-ID: <aaWyLWmqx0KCJvwI@fedora>
References: <aZRB7Reu/D6HvRcb@fedora>
 <20260302-mighty-wondrous-seagull-75085c-mkl@pengutronix.de>
 <20260302-condor-of-nonconcrete-infinity-d3ddbb-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-condor-of-nonconcrete-infinity-d3ddbb-mkl@pengutronix.de>
X-Rspamd-Queue-Id: E5B981DC3E9
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
	TAGGED_FROM(0.00)[bounces-6686-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 02:23:42PM +0100, Marc Kleine-Budde wrote:
> On 02.03.2026 11:30:34, Marc Kleine-Budde wrote:
> > > +static int virtio_can_open(struct net_device *ndev)
> > > +{
> > > +	virtio_can_start(ndev);
> > > +
> > > +	netif_start_queue(ndev);
> > > +
> > > +	return 0;
> > > +}
> >
> > Is open_candev() missing? The CAN framework requires drivers to call
> > open_candev() in their ndo_open handler. open_candev() validates that
> > bittiming has been configured (returns -EINVAL if bitrate is 0), checks
> > CAN FD data bitrate requirements, and manages carrier state. Without this
> > call, can the device be brought up without configuring bitrate? The driver
> > does call close_candev() in virtio_can_close(), showing awareness of the
> > CAN lifecycle. Every other CAN driver in the kernel calls open_candev() in
> > its open function.
> 
> This is true for physical CAN devices, so let's clarify things for
> virtio.
> 
> As far as I can see, there's no interface to get/set the bit timing/bit
> rate from the guest, right?
> 
AFAIU there is not such a interface.

> You can set bittiming.bitrate to CAN_BITRATE_UNKNOWN, remove the
> netif_carrier handling from virtio_can_start() and use open_candev().
> 
Will do. Thanks!

Matias


