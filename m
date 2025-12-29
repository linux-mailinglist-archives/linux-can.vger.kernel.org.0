Return-Path: <linux-can+bounces-5961-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDEBCE7F5B
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 19:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4710301F254
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA00285CA9;
	Mon, 29 Dec 2025 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4Y5Aifr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o+Jz0f2S"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B12D94AF
	for <linux-can@vger.kernel.org>; Mon, 29 Dec 2025 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767034449; cv=none; b=bj7HdTgZGSq0mguAHF3ERrK5wBkVT7TxHC8hOPnXzg6BTwqWyo/vSOCojVgSis1RHilPreS9NDPtkqDMjxCK4YnKbjbp8tv3ZAfoi1aju4YG1jg//NlUZqbOWmMrJF58FIXbtW/J9iOqNH4u+caE/m2HHH17OC98VW1+4IbgWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767034449; c=relaxed/simple;
	bh=ALsUiIBCVP8geGDQ6+TxfFqJgx+BhWAjolmbt0SW/j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL1Dl4qpAh+gm08NJ+IrH/95vetXq2K8LpNTYreNIjcLLBSZPurzLF80/O6mw2cyRp4zhGpXAl0iErO4fgF5UvvL8me5wIwh2iJI4SX9dE6oNJQKlNBYsMVfMUUVR5aQvnoHVyUO68ZTvyH2nVtehsnZqeKtOkmgG/VdQmj4fcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4Y5Aifr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o+Jz0f2S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767034444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqPBQgLRYrlIHGsVNMYaGcMUVg0RDtzqoeXG7bJIlU=;
	b=V4Y5AifrHN652+AwbEE5m6P7ZHVI7JSrMssJJkDHU998fbg9UhxuD/WdtT2HqXETB6NtqN
	zhTK6LKElqcqWUSVrvJH7iRwpgrneXku1QY5dDzCUC2dJcyse/FBZsLsiZmgCG93Sv3Sbz
	KnD424Y4mXlDA9rtROITJ+/mo2j2xxs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-2atNvjRCNya5R4PNqd27DA-1; Mon, 29 Dec 2025 13:54:03 -0500
X-MC-Unique: 2atNvjRCNya5R4PNqd27DA-1
X-Mimecast-MFC-AGG-ID: 2atNvjRCNya5R4PNqd27DA_1767034442
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477771366cbso69894935e9.0
        for <linux-can@vger.kernel.org>; Mon, 29 Dec 2025 10:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767034442; x=1767639242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXqPBQgLRYrlIHGsVNMYaGcMUVg0RDtzqoeXG7bJIlU=;
        b=o+Jz0f2STOEgiZu9sJfJjplnSzzL8MXSRKBdKvFC7EFe/DVCY8+2okWbSAy5d9JlPb
         2kEkMBr//hz7t0AJ3RvRaN+2KipHWqD1L7vcBvrahCQGPxqBDbVzHE0whok4W/X/AWiz
         PgdTwDtRYm+7HfHQdkResTxCOvdRghqxuS0GZmmdiL9pWIryM0Gvf67f3ddt5c0bPrzr
         +dFp209tGAX1jDBU+PQoW10GGHb5nUI4WK8l5ZPoS9RimgRQ8gSoWqsIu7rxuTglVqrQ
         QaLrREszgVMiZESgs/0rm5gfyJMkspB6p/OChhn5fT1yjvPYtQ4M6atEZHjyThv+M2zL
         ylsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767034442; x=1767639242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXqPBQgLRYrlIHGsVNMYaGcMUVg0RDtzqoeXG7bJIlU=;
        b=MOaCy0kRZttTGKU+MmRHx/6Spv6Jil7LUGsoGBdKxL1RxD3xXJ3Yvl7BsuavZRIrd/
         BvtNiMqhCm1LCAP/HQw5jnKOdIETl3FyCuRSH0S7ESaFCQOgay3MRXPXXCBm7OhuIYnK
         8VEHBgES8jCJXd97ILZwX1LoMIgbfboXar+VD3iWFYknA1RdEHwj4KX574CG/QXOwMOv
         iz1eEmJCE/yorBCkSOAmyADr2JuLCEFBDlk+9Y+83GKlhimeut6QeynwrCuyo6K0ApFc
         0ph9IJJRWmbWtcuxcqMN5FzmMHbMIw9RCNpS417VoLbBChIxukaTaSuDwKjX8Li1cHrs
         NvJA==
X-Forwarded-Encrypted: i=1; AJvYcCXL/k+uwHsskf7FODN1mFQxbWpz4dXg5VNF8OgcLnAViVO7A0otcyKn1fcUCcaE7c8elbGiNKOw+lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6LIILVjQV8xCEwRutNspqCi/WvgO/o4mgBpOusRIT4Uw3bLL
	+kBcrGqo4fijdHhTjsEmz/go5sjjwTsa/yQ+7En4odWCD1uTXvdIbzEBfM+J9OpaMtBPpSIgcvt
	EWtp1ADPu4iVKzuKXoFQORskblZOCRhzl/mEDCVxPrZN9dQqARXVQH0t1GvHuzw==
X-Gm-Gg: AY/fxX6x/x2UJ37pIo9b6n64MKQ0/mBjKZAnukof02ijCTU7UEKjLEF13GTia6M6nYx
	KCd2oSJ+9286pQbEEiX7jPepK3RasGRur+tX5hbkpPT5AAjrxuLEso036yYtW3lzsSPXfwvwmEF
	KlQu88YsuwJ3egvxAi7wMrIivzDX2D7yxXxbHjfBvdPKopSXLErRtOPcTasqfINdtAg/7KYC6kU
	qIMi/gBR3eYC2w2WaSkyyD532/cewTC7YnhXOaQEGIeiyWi5qse3Iz7yixPYffz9cbSHMFiNmrg
	fsDC4OwtYm08UjjPdNJnClu4YSLzs5pC5uqzdr8XY/SYdeThZcDq1JeNEUhNDwScE41ZTcU3K6k
	=
X-Received: by 2002:a05:600c:608f:b0:477:63b5:6f76 with SMTP id 5b1f17b1804b1-47d19582bfcmr334575845e9.25.1767034441936;
        Mon, 29 Dec 2025 10:54:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN6QBrMG97keY2S7yt5vDGc2N4OxYlR/W7KsOyP3r7gNQ0AQt4pBUtJauYyRw6/rkIMt53fw==
X-Received: by 2002:a05:600c:608f:b0:477:63b5:6f76 with SMTP id 5b1f17b1804b1-47d19582bfcmr334575445e9.25.1767034441433;
        Mon, 29 Dec 2025 10:54:01 -0800 (PST)
Received: from fedora ([37.169.20.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm578676005e9.9.2025.12.29.10.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:54:01 -0800 (PST)
Date: Mon, 29 Dec 2025 19:53:48 +0100
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
Message-ID: <aVLOPMmpvArnVAHZ@fedora>
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

I tried this and I could not reproduce it. [2] requires a minimal change
to apply, i.e., qdev-properties.h has changed to /core. I'll send a v2
for that. I used latest vhost-device-can. I run `candump can0` in the
guest and `while true; do cangen vcan0; done` in the host. Am I missing
something?

Thanks,

Matias


