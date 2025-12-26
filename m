Return-Path: <linux-can+bounces-5941-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF8CDF011
	for <lists+linux-can@lfdr.de>; Fri, 26 Dec 2025 21:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2309C3006A93
	for <lists+linux-can@lfdr.de>; Fri, 26 Dec 2025 20:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBAE2FC02F;
	Fri, 26 Dec 2025 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S28BTa9k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBuahJGG"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AFC2459CF
	for <linux-can@vger.kernel.org>; Fri, 26 Dec 2025 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766782381; cv=none; b=hcymL0ig+gK6wWU41CaVMl0DJN7S0XPDOYsChahzcXzhairXKKDlZD51khFK0L31RI+p2Ut+ELxwTbm3RYMi+4jZz7MRxbANDUO0sCigm//EJoCp6U+xou8O8gNE1bJbdsATNFhIc3BdvS2i27NZO8GPWbUEAEtQUQSMAYLcS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766782381; c=relaxed/simple;
	bh=cQBlcaWGY3fQE/osFSFcd47vyjxZ0/GtU7ALTs+T5o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKgS85X8y9ESR5THbsOdB4l0Rk7RIDvCyw51+pbSr+zt0pNuhRnqrRNXVV+ksqYFP7Qf7AKVj4V6YJqK9/jD3UTFmK9RB+QrxEVLDz9KjVLeGFafVxpMQHTMhTu21WYXM60SwmXp/V4Lx/s7tZjrhy7gJYQpj1uqECSmDZpouQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S28BTa9k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBuahJGG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766782378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06/0GOfuLECGxOgF+sjTq5KDrdjOZge5WvhzbJu0tt8=;
	b=S28BTa9ksiDOKDJcdSbZ0mAJY2+aNcMmZYd2u79Jq5SYRsM8epxI14X5rMbPwS9Jsxb0dB
	Sc3VXGkN0VxroaMFMIOuaR4QPaIc4nou2FmocLgfVtX17wq39L61YRHQnmVvlfjoeAMZfu
	40DMAc+JORGxmz7Jm+Ia2lAZSH8iB1g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-KeM1QgNoMb2lyCb_2iwtpg-1; Fri, 26 Dec 2025 15:52:57 -0500
X-MC-Unique: KeM1QgNoMb2lyCb_2iwtpg-1
X-Mimecast-MFC-AGG-ID: KeM1QgNoMb2lyCb_2iwtpg_1766782376
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0c495fc7aso111680175ad.3
        for <linux-can@vger.kernel.org>; Fri, 26 Dec 2025 12:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766782376; x=1767387176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=06/0GOfuLECGxOgF+sjTq5KDrdjOZge5WvhzbJu0tt8=;
        b=OBuahJGGeRsFEQP/jMD+iMu6jQKim5vVH89+qDZ60+89q4+mKFTESEMX39R5ZT+hAz
         gq/GMxQd+AdbqwfCtyd22d7vjjV8Kypg7HQCXa0wcmZyyiZuARTPSrXdCcfn6H/kB1l0
         OTKqV7so6otUcmjiB0nkqSllCqHruCk74upeb/l6waBkh3YI/dmu06Vbp3SaOPngbq+h
         hdGiHeJBKxxnAUdxlisrwgNzxBZlkROUyIvqVLsokBR1u06ubWxLR/rFJW+vMWQWz88m
         Vc9eH2IvQ9l8cPME2reJMVlWwJlxIaambrQqZYA1csNt/75rv9CNltDhpItbnIQzvBqB
         MqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766782376; x=1767387176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06/0GOfuLECGxOgF+sjTq5KDrdjOZge5WvhzbJu0tt8=;
        b=ujwjdpPnuTmoXc84sRW3vP+psl3YPSkkKxjnMWybhXkz++gzucbG8EXYa1szS95/HJ
         DNKs/pN5Pfc4fU+qAmAXEW/liL+7KEZwhWKcZKbHIdED4CCf+GC8y2eSuaqZCBdIm+S8
         oVWROS4tG8yra9RepEmJfiXXwYg7p91Hk5VyDsYcopsWRzeeb0hER2TmTg4Hhhq/KD4c
         gxl+aKG/OZKFAaBhm65QLwppteZeOymZxjuGZM/d88e74EypQC+DRo+vr+vKKMADZtNX
         GmUnhwRw/13hxvyEXVxTJhORBBBBBs+PZNK8ejU+oc2a94XA1U+Ow6Sul0nsT3G+jnac
         o8PA==
X-Forwarded-Encrypted: i=1; AJvYcCVJZtx92pqm1ehcxy7Nq+MmF9WAeUecNkHacMQVG/Gd1DFLdYqDePTTPqGWOyrwArjTQQOWs7b0P5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGEnvSkvS3kdvLA5wlGTQ0GzLOSD1NdE4RpdaJwVdA7QNY5ne
	03uW3YCfsrNB4w5+Iom/QE5y03n6sZ5uhY/svpfH3Gf7AwIDdQW5zZTWZqJl3MZK+arbt8j4Xnm
	B56yoUlNWDu23vInwhIenX4kBFm1qrVmGmwGqUJF/aMkom4AtTex+eMIrIYZC6w==
X-Gm-Gg: AY/fxX4wDFs4z5h3DbTwkyVFQFBHauGhcdEuSGvv/jvfkJP6appu7C+VuQ1gV6Thu7Q
	P+HISOuIIKYyqCswLkvsVGis1G2XtERas36zhelRzd/OTg/Rl12MhTMbGs0tTZP38IXMtFYcQ8H
	vhbnfxIBzfM+u2/hbEjEstMocfGoE6JVYZfqezvrDYsmiVdJ/KeLO6HKoS3uTjX6uNdXKxxQ7A6
	wYKOX6YW3kW/cUPGj+mzGUyLJInydEeZwtqok9SkNvmCgGnGO960DKsSI21yqBnlDM7PioSsJ0h
	ZRPJu8cbvfRfNgDTStq9WuRre3QqQViNKuz3XRkyUi5ZFuR41sjIqhV6EZVUfD6xyR0D3mQKCjr
	ugWS8/5PkaMbbN7YfuqmdOTAnKU+AELqnxfYY/RlM7JNHtkI=
X-Received: by 2002:a05:7022:6887:b0:11b:ca88:c50f with SMTP id a92af1059eb24-121722e9d56mr26505063c88.40.1766782375755;
        Fri, 26 Dec 2025 12:52:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhwIUt9pEQyngSRuvJZmbkbfSZHfZftAvl4xfxhsycFUKwbQ7pcv5VQNK2Q3IpgtQB1QhjFg==
X-Received: by 2002:a05:7022:6887:b0:11b:ca88:c50f with SMTP id a92af1059eb24-121722e9d56mr26505034c88.40.1766782375164;
        Fri, 26 Dec 2025 12:52:55 -0800 (PST)
Received: from fedora (pinamar-179-51-86-121.users.telpin.com.ar. [179.51.86.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm88131913c88.1.2025.12.26.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 12:52:54 -0800 (PST)
Date: Fri, 26 Dec 2025 21:52:48 +0100
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
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aU71oJScQ8aC0npw@fedora>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aT7XAsTWr0_yyfx_@bywater>

On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> Hi Matias,
> 
> On Thu, Dec 11, 2025 at 06:52:21PM +0100, Matias Ezequiel Vara Larsen wrote:
> > Thanks for your comments, I took most of them. I have some questions
> > though. 
> > 
> 
> (snip)
> 
> > > > + */
> > > > +static int virtio_can_add_inbuf(struct virtqueue *vq, void *buf,
> > > > +				unsigned int size)
> > > > +{
> > > > +	struct scatterlist sg[1];
> > > > +	int ret;
> > > > +
> > > > +	sg_init_one(sg, buf, size);
> > > > +
> > > > +	ret = virtqueue_add_inbuf(vq, sg, 1, buf, GFP_ATOMIC);
> > > > +	virtqueue_kick(vq);
> > > > +	if (ret == 0)
> > > > +		ret = vq->num_free;
> > > 
> > > The returned value in case of success (i.e.: vq->num_free) is not used.
> > > 
> > 
> > I removed it this but something is not working anymore so I need to
> > investigate.
> >
> 
> That should't happen, since vq->num_free is defined as an unsigned int
> and no caller is reacting on return values >= 0.
> 
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +/* Send a control message with message type either
> > > > + *
> > > > + * - VIRTIO_CAN_SET_CTRL_MODE_START or
> > > > + * - VIRTIO_CAN_SET_CTRL_MODE_STOP.
> > > > + *
> > > > + * Unlike AUTOSAR CAN Driver Can_SetControllerMode() there is no requirement
> > > > + * for this Linux driver to have an asynchronous implementation of the mode
> > > > + * setting function so in order to keep things simple the function is
> > > > + * implemented as synchronous function. Design pattern is
> > > > + * virtio_console.c/__send_control_msg() & virtio_net.c/virtnet_send_command().
> > > > + */
> > > 
> > > Comment is not really helpful nor informative, at least for me. I'd drop
> > > the AUTOSAR part at least.
> > > 
> > 
> > I removed it.
> > 
> > > > +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> > > > +{
> > > > +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > > > +	struct virtio_can_priv *priv = netdev_priv(ndev);
> > > > +	struct device *dev = &priv->vdev->dev;
> > > > +	struct virtqueue *vq;
> > > > +	unsigned int len;
> > > > +	int err;
> > > > +
> > > > +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > > > +
> > > > +	/* The function may be serialized by rtnl lock. Not sure.
> > > > +	 * Better safe than sorry.
> > > > +	 */
> > > > +	mutex_lock(&priv->ctrl_lock);
> > > 
> > > Consider the newer guard() syntax:
> > > 
> > >     guard(mutex)(&priv->ctrl_lock)
> > > 
> > 
> > IIUC this adds the unlock automatically, right?
> >
> 
> Yes, as soon as the function returnsi, and even in case of early
> returns.
> 
> > > > +
> > > > +	priv->can_ctr_msg.cpkt_out.msg_type = cpu_to_le16(msg_type);
> > > > +	sg_init_one(&sg_out, &priv->can_ctr_msg.cpkt_out,
> > > > +		    sizeof(priv->can_ctr_msg.cpkt_out));
> > > > +	sg_init_one(&sg_in, &priv->can_ctr_msg.cpkt_in, sizeof(priv->can_ctr_msg.cpkt_in));
> > > > +
> > > > +	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
> > > > +	if (err != 0) {
> > > > +		/* Not expected to happen */
> > > > +		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
> > > > +		mutex_unlock(&priv->ctrl_lock);
> > > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > > +	}
> > > > +
> > > > +	if (!virtqueue_kick(vq)) {
> > > > +		/* Not expected to happen */
> > > > +		dev_err(dev, "%s(): Kick failed\n", __func__);
> > > > +		mutex_unlock(&priv->ctrl_lock);
> > > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > > +	}
> > > > +
> > > > +	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
> > > > +		wait_for_completion(&priv->ctrl_done);
> > > > +
> > > 
> > > Since the call is synchronous, does can_ctr_msg really need to be part
> > > of priv? Cannot be it allocated from the stack?
> > > 
> > 
> > I moved it to the stack.
> > 
> 
> This was a bad suggestion, as Michael S. Tsirkin suggested in another
> branch of this thread [0]. Sorry.
> 
> > > > +	mutex_unlock(&priv->ctrl_lock);
> > > > +
> > > > +	return priv->can_ctr_msg.cpkt_in.result;
> > > > +}
> > > > +
> > > > +static void virtio_can_start(struct net_device *ndev)
> > > > +{
> > > > +	struct virtio_can_priv *priv = netdev_priv(ndev);
> > > > +	u8 result;
> > > > +
> > > > +	result = virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_START);
> > > > +	if (result != VIRTIO_CAN_RESULT_OK) {
> > > > +		/* Not expected to happen */
> > > > +		netdev_err(ndev, "CAN controller start failed\n");
> > > > +	}
> > > > +
> > > > +	priv->busoff_pending = false;
> > > > +	priv->can.state = CAN_STATE_ERROR_ACTIVE;
> > > > +
> > > > +	/* Switch carrier on if device was not connected to the bus */
> > > > +	if (!netif_carrier_ok(ndev))
> > > > +		netif_carrier_on(ndev);
> > > > +}
> > > > +
> > > > +/* See also m_can.c/m_can_set_mode()
> > > > + *
> > > > + * It is interesting that not only the M-CAN implementation but also all other
> > > > + * implementations I looked into only support CAN_MODE_START.
> > > > + * That CAN_MODE_SLEEP is frequently not found to be supported anywhere did not
> > > > + * come not as surprise but that CAN_MODE_STOP is also never supported was one.
> > > > + * The function is accessible via the method pointer do_set_mode in
> > > > + * struct can_priv. As usual no documentation there.
> > > > + * May not play any role as grepping through the code did not reveal any place
> > > > + * from where the method is actually called.
> > > > + */
> > > 
> > > The do_set_mode method is used e.g. to restart the CAN after a bus-off event.
> > > 
> > 
> > Do you think we need to support CAN_MODE_STOP?
> >
> 
> No, I don't think so, but the comment is somewhat misleading and feels
> more like some private notes.
> 
> > > > +static int virtio_can_set_mode(struct net_device *dev, enum can_mode mode)
> > > > +{
> > > > +	switch (mode) {
> > > > +	case CAN_MODE_START:
> > > > +		virtio_can_start(dev);
> > > > +		netif_wake_queue(dev);
> > > > +		break;
> > > > +	default:
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> 
> (snip)
> 
> > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > +{
> > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > +	struct net_device *dev = can_priv->dev;
> > > > +	struct virtio_can_tx *can_tx_msg;
> > > > +	struct net_device_stats *stats;
> > > > +	unsigned long flags;
> > > > +	unsigned int len;
> > > > +	u8 result;
> > > > +
> > > > +	stats = &dev->stats;
> > > > +
> > > > +	/* Protect list and virtio queue operations */
> > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > 
> > > The section below seems a pretty big one to protect behind a spin lock. 
> > > 
> > 
> > How can I split it? 
> > 
> 
> Question here is: what needs to be protected? As far as I can tell, the
> only entity needing some kind of locking here is the queue, while both
> ida_* and tx_inflight operations are already covered (the former by
> design [1], the second because it's implemented using an atomic.
> 
> If I'm not wrong (but I might be, so please double check) this can be
> limited to:
> 
> 	/* Protect queue operations */
> 	scoped_guard(spinlock_irqsave, &priv->tx_lock)
> 		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
> 
> 
> Maybe the whole locking pattern is a leftover from a previous version, 
> where a list of TX messages was kept?
> 

I followed this approach for the three queues. I wonder why the rx queue
and the ctrl queue use a mutex instead of spinlock? I added a mutex for
the operations to the rx queue.

Matias

> > > > +
> > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > +	if (!can_tx_msg) {
> > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > +		return 0; /* No more data */
> > > > +	}
> > > > +
> > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > +	} else {
> > > > +		result = can_tx_msg->tx_in.result;
> > > > +	}
> > > > +
> 
> (snip)
> 
> > > > +static int virtio_can_probe(struct virtio_device *vdev)
> > > > +{
> > > > +	struct virtio_can_priv *priv;
> > > > +	struct net_device *dev;
> > > > +	int err;
> > > > +
> > > > +	dev = alloc_candev(sizeof(struct virtio_can_priv),
> > > > +			   VIRTIO_CAN_ECHO_SKB_MAX);
> > > > +	if (!dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	priv = netdev_priv(dev);
> > > > +
> > > > +	ida_init(&priv->tx_putidx_ida);
> > > > +
> > > > +	netif_napi_add(dev, &priv->napi, virtio_can_rx_poll);
> > > > +	netif_napi_add(dev, &priv->napi_tx, virtio_can_tx_poll);
> > > > +
> > > > +	SET_NETDEV_DEV(dev, &vdev->dev);
> > > > +
> > > > +	priv->dev = dev;
> > > > +	priv->vdev = vdev;
> > > > +	vdev->priv = priv;
> > > > +
> > > > +	priv->can.do_set_mode = virtio_can_set_mode;
> > > > +	/* Set Virtio CAN supported operations */
> > > > +	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
> > > > +	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
> > > > +		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD);
> > > > +		if (err != 0)
> > > > +			goto on_failure;
> > > > +	}
> > > > +
> > > > +	/* Initialize virtqueues */
> > > > +	err = virtio_can_find_vqs(priv);
> > > > +	if (err != 0)
> > > > +		goto on_failure;
> > > > +
> > > > +	spin_lock_init(&priv->tx_lock);
> > > > +	mutex_init(&priv->ctrl_lock);
> > > > +
> > > > +	init_completion(&priv->ctrl_done);
> > > > +
> > > > +	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD))
> > > > +		priv->sdu_len = CANFD_MAX_DLEN;
> > > > +	else
> > > > +		priv->sdu_len = CAN_MAX_DLEN;
> > > 
> > > Consider replacing sdu_len with something like rpkt_len, which is
> > > directly related to priv->rpkt and can make code more readable, here and
> > > in other locations. E.g.:
> > 
> > I replaced it with rpkt_len.
> > 
> > > 
> > > 	priv->rpkt_len = sizeof(struct virtio_can_rx);
> > > 	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD))
> > >     		priv->rpkt_len += CANFD_MAX_DLEN;
> > > 	else
> > > 		priv->rpkt_len += CAN_MAX_DLEN;
> > > 
> > > 	priv->rpkt = kzalloc(priv->rpkt_len * ...
> > > 
> > > > +
> > > > +	priv->rpkt = kzalloc((sizeof(struct virtio_can_rx) + priv->sdu_len) *
> > > > +						priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free,
> > > > +						GFP_KERNEL);
> > > 
> > > If I'm not mistaken, priv->rpkt is never freed. Consider moving to
> > > devm_kzalloc().
> > > 
> > 
> > Done.
> > 
> > > > +	if (!priv->rpkt) {
> > > > +		virtio_can_del_vq(vdev);
> > > > +		goto on_failure;
> > > > +	}
> > > > +	virtio_can_populate_rx_vq(vdev);
> > > > +
> > > > +	err = register_virtio_can_dev(dev);
> > > > +	if (err) {
> > > > +		virtio_can_del_vq(vdev);
> > > > +		goto on_failure;
> > > > +	}
> > > > +
> > > > +	napi_enable(&priv->napi);
> > > > +	napi_enable(&priv->napi_tx);
> > > 
> > > Most of the existing drivers enable the napi(s) during the open() phase,
> > > IIUC to avoid scheduling napi operations for devices that might never
> > > get used. But here maybe there is a specific reason to do it this way?
> > > 
> > 
> > I do not have idea. I moved to open() and something stopped to work. I
> > am investigating it.
> >
> 
> On a second thought, it may be wiser to have the napis enabled on probe,
> to drop the incoming messages even when the interface is brought down.
> 
> (last snip)
> 
> 
> While stress testing this, I noticed that flooding the virtio-can
> interface with packets leads to an hang of the interface itself.
> I am seeing this issuing, at host side:
> 
> 	while true; do cansend can0 123#00; done
> 
> with:
> 
>  - QEMU: the tip of the master branch plus [2]
>  - vhost-device: the tip of the main branch
> 
> and the following QEMU invocation:
> 
> qemu-system-x86_64 -serial mon:stdio \
>     -m 2G -smp 2 \
>     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
>     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
>     -append "loglevel=7 console=ttyS0" \
>     -machine memory-backend=pc.ram \
>     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
>     -chardev socket,id=can0,path=/tmp/sock-can0 \
>     -device vhost-user-can-pci,chardev=can0
> 
> 
> Restarting the interface (i.e.: ip link set down and the up) does not
> fix the situation.
> 
> I'll try to do some more testing during the next days.
> 
> 
> > Thanks for reviewing it!
> > 
> > Matias
> > 
> >
> 
> Regards,
> Francesco
> 
> 
> [0] https://lore.kernel.org/linux-can/20251214022000-mutt-send-email-mst@kernel.org/
> [1] https://elixir.bootlin.com/linux/v6.18.1/source/lib/idr.c#L323
> [2] https://lore.kernel.org/qemu-devel/20251031155617.1223248-1-mvaralar@redhat.com/
> 
> 


