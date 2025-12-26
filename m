Return-Path: <linux-can+bounces-5942-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA95ECDF15A
	for <lists+linux-can@lfdr.de>; Fri, 26 Dec 2025 23:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 533DE3005191
	for <lists+linux-can@lfdr.de>; Fri, 26 Dec 2025 22:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35F274658;
	Fri, 26 Dec 2025 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="H8e+o0yd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="sEyJ3Icc"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC244347C6
	for <linux-can@vger.kernel.org>; Fri, 26 Dec 2025 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787781; cv=pass; b=uFOGrtMFBgxIXDHOTIfyT6uUCYOkalKDOPFX0lauAKR9YoKbs92zZKxKB7qsvMmo6H2Liuch4KwwHVUrLJDIp6ikKlpgX1MO3E7D9Hq5iazi+pY0DOddCTWMI+6WCwvD9ecL5Db70PH+CTyyRBSmIeLhH4vUeNKEV+b3yUwD/Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787781; c=relaxed/simple;
	bh=bav4IRLbYgm2lLajgHgDzg+MDRlm47GGHNmgd8nNXJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2YZyHxBCmkuLMk/xX7H1joyazjMZtFVJTc6i31odvUnj+UIplVxUCo8arqSQieXyCORGcV/0VDB8Yzqwd26p5kEondSqa2o3mnV67zbTAhmi95lskD/vx0LxJMgX+oxHixZx9+73/sIZiVbkxeWn5tbdmTXfssaokgUVfV9FS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=H8e+o0yd; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=sEyJ3Icc; arc=pass smtp.client-ip=185.56.87.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-txfd.prod.antispam.mailspamprotection.com; s=arckey; t=1766787779;
	 b=qNlZuaxzSbc8LPzEfVQkSDmJd/JHcBW9kR9syi1kgcfx1WDvxhDrQenMQYo9UW2EInuBX9BC2+
	  lkSOZHZiSmK6s1cbtmv0ZCHOFYTx/4aApRgXTZHMpqzcmlgPlyMavHJr3szk/x23RfraBd9QIr
	  DQtu8ogksRGPQgUzp7mroOG6d7W5kqJTZWl+yd9u8V0CQEq+N4/nnq9bHsMPDJxATVmZqrttvY
	  yokGCnbqhzvJ55PbojKMuCqJ+PTNrBz4nCmGi0vpbY+yCy3AvVsNVJqecSUPKHzcXYAXfGdCi9
	  EYaruDCG4Xjo2r/p4HW3QvHsocUFICFf3Y3ROTLD2cQX4g==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-txfd.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-txfd.prod.antispam.mailspamprotection.com; s=arckey; t=1766787779;
	bh=bav4IRLbYgm2lLajgHgDzg+MDRlm47GGHNmgd8nNXJk=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=B+qBp1lfwkZD0rPVA9CdhVNrCcmEvjiZVMGbCWbl2Q1QcYhFGKwu/LEbGJkrrkdSnJOgTW6TeU
	  wpw2sLd23VvUAkTcWX5hBlsRuUwmh7HlvUN1XVYS04kST30szM+W5G50rqzHBL6w/FQZIDqlSg
	  s8sIsnM5nHseSy02nVJ90yJOlDJgpvaRn/ah1KxK8qqF50JmA7iEP3961w5gCJlQTluxH6CId/
	  6kcGm9pn6QtmPkfyTysHDQ2QktP+iyoJ1ZR1/4H6zk3P5BID6rQl8o1jAuIZB9BnjSL83QapxT
	  xg0Cfp4m3b8s7i+iAKjS2pNO2uPR1PIqcY6CZ0z9MSXdzA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=uwxcfM2nIoMiJ/2Cxvig6X/YBuR8saav4O8t3bsIEzg=; b=H8e+o0yd0WstlKyov0g1MtVZ1r
	vmYNGyeRigMPRvoZVLlFjOKVv1S1jPmMEFYfy4drRY5HaSLq6Ia8Kk+IY9nvD+1i66EyNfSciz7tJ
	f9wiappLgmY/tIh4/emuq3NviGmTPShG1eURUOfcRKhm7wdarTk6uPwhBBCwlWeL4Lzk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-txfd.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vZGD1-00000004cjJ-0XEk
	for linux-can@vger.kernel.org;
	Fri, 26 Dec 2025 22:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=uwxcfM2nIoMiJ/2Cxvig6X/YBuR8saav4O8t3bsIEzg=; b=sEyJ3IccJgOLjH0XhYCQHnwT9S
	ngKkeBgcBkv6Lo//RWEVtIXXHj+1OEYB3m830PyESrBXPOB3TG3SxdwbzYcAS7n4STHsJkUSn/aM0
	5c1Y/6WrURrnRiUyNCQFp8W+Ijq+ZiYtZ8wp7wg6ejKIFhoZpOqZvVUK8yUHsJp6k64w=;
Received: from [95.248.141.113] (port=64047 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vZGCm-00000000Lwd-0IpK;
	Fri, 26 Dec 2025 22:22:40 +0000
Date: Fri, 26 Dec 2025 23:22:38 +0100
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
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
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aU8Krjsv0_aC3E7A@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aU71oJScQ8aC0npw@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aU71oJScQ8aC0npw@fedora>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: d1ca6eb2daf46b6ac41b49029e98e949
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vZGD1-00000004cjJ-0XEk-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-txfd.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Fri, Dec 26, 2025 at 09:52:48PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > +{
> > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > +	struct net_device *dev = can_priv->dev;
> > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > +	struct net_device_stats *stats;
> > > > > +	unsigned long flags;
> > > > > +	unsigned int len;
> > > > > +	u8 result;
> > > > > +
> > > > > +	stats = &dev->stats;
> > > > > +
> > > > > +	/* Protect list and virtio queue operations */
> > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > 
> > > > The section below seems a pretty big one to protect behind a spin lock. 
> > > > 
> > > 
> > > How can I split it? 
> > > 
> > 
> > Question here is: what needs to be protected? As far as I can tell, the
> > only entity needing some kind of locking here is the queue, while both
> > ida_* and tx_inflight operations are already covered (the former by
> > design [1], the second because it's implemented using an atomic.
> > 
> > If I'm not wrong (but I might be, so please double check) this can be
> > limited to:
> > 
> > 	/* Protect queue operations */
> > 	scoped_guard(spinlock_irqsave, &priv->tx_lock)
> > 		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
> > 
> > 
> > Maybe the whole locking pattern is a leftover from a previous version, 
> > where a list of TX messages was kept?
> > 
> 
> I followed this approach for the three queues. I wonder why the rx queue
> and the ctrl queue use a mutex instead of spinlock? I added a mutex for
> the operations to the rx queue.

If I interpreted correctly (but maybe Harald can shine some light on this):

- the virtio_can_send_ctrl_msg() uses a mutex because it could be
  executed in parallel by different actors (read: userspace processes
  invoking up and down operations); moreover, is the whole control
  operation that needs to be protected and not only the access to the
  virtqueue_ functions, so a mutex should make sense;
- the rx queue shouldn't actually need any locking, since it is accessed
  only by the poll function and the network framework should guarantee
  that no multiple parallel poll operations are called on a napi;
- the tx queue needs instead to be protected, since it could
  concurrently be accessed by both the start_xmit callback and the poll
  function; a spinlock there makes more sense, as accesses should be
  very short.

> 
> Matias
> 
> 

Thank you

Regards,
Francesco


