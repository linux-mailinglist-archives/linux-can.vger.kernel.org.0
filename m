Return-Path: <linux-can+bounces-5864-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD81CBBC7E
	for <lists+linux-can@lfdr.de>; Sun, 14 Dec 2025 16:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3135B3006A81
	for <lists+linux-can@lfdr.de>; Sun, 14 Dec 2025 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613632BDC03;
	Sun, 14 Dec 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="z4lLiGeI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="Mle8mQFF"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6942BD586
	for <linux-can@vger.kernel.org>; Sun, 14 Dec 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765725984; cv=pass; b=KPIVtJgGv0ciDIXMKrxqHCIgwLPSEUjtGXPYmr09XW9T0rDwQedneLAhIR0rbdNX4A+KwLVKTJadNb9ufONIvCLL8z9LgMcrdDDe/ESpf9W59th48IWChBXhCVDeX7qGwaTxxocqEfG1qTUjCXZLq7ZwZkFNqKu2Px0kI7hfdV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765725984; c=relaxed/simple;
	bh=YQjlAwSHWcd1kxUSnEm9sEjhrE398KSvKBhd7mzuY/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMNFca8XS3aRjM7sHtb7387nQvSaVF7fOYqQolRtbn2iUKlUXpNUwCcyImHxvp/sOYsBFr5Uz+qeJqhXFJyGJGnU+8EecEPoL2CEAB+yNTmMVHomUn3+zxw49sBWdBAXUQX0DZKEUkNuEAFrsGYR2N6WA724f6u7ZX1ISahW+pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=z4lLiGeI; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=Mle8mQFF; arc=pass smtp.client-ip=185.56.87.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-0cck.prod.antispam.mailspamprotection.com; s=arckey; t=1765725981;
	 b=Ic/U8+f/dJaLm2zUZRvgCHgPFPa/jqaqi20j35qa4UcS/SmB43yTAZ72MaVOvOXAOHnzbCeZJJ
	  8uK05SNyqpV7IOcqPwYtsGTeQSqaLr/YlAqMHKCgfJod/S7++Ow2x2yVoH/WE7ZcJ9KOPG+gEK
	  YJ4tokH4aWKdAV7R/SJHfqyrjzLp2djgkwF2j9m7QrIlk3xddXBf0Y80qxIk0c7EQN3YvaPu3J
	  TUhrv9UiAvia2NYeqkN7/ifawCYyYsfyAj1jwPBioWpq6sBL+4YARqVAyPMkiAJxvH/UD6Gg/1
	  93NE+i1iWqJkp+PPqvsZ77REPOiGRLzTprUL4QCS5dpVpw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-0cck.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-0cck.prod.antispam.mailspamprotection.com; s=arckey; t=1765725981;
	bh=YQjlAwSHWcd1kxUSnEm9sEjhrE398KSvKBhd7mzuY/Q=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=ldAslwIeqhh4lfmRQBdqOC7AGm2Eznx2nJDc98RKe4irCJJXV8neqHXARn5wKoo1kjYpxywc/I
	  T4tzUqDjp6gpEqcygJx3R9jKiYr3rKhKYrSdw3U4fFz+bldME7QRoLRQ2pBeLSHtqnn+SRFoMT
	  rAvDrE8JqXpQy//CaHntZOR8ojsCJq5npWQtmgitJ7vrxmw1K5mYmPlZ+fYv+ohtUImDUKqe05
	  8vpXkrR3Ng6tQKmk9yrrODC7oKAadVamos05slaiTZWpNQ3IUGKLBuqpJInq9tu20QISKlE456
	  thOv5ycQmTV+7CT16Wv0uqGBCe5bFCivIUFFzGzXRSCVKw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=chDnHXzC7OmgMSvhcFfltAlCclhS52mGTR4eaadE5Jc=; b=z4lLiGeIf9k/WAZpdmLV/9MSsL
	N6Hrl+VoKvUh8UMd/LW73QyR12zS+BXcI0uTUwYdjvAmYIcI7FfcgTjNV/m/zUOtoysDyn2OdcQX6
	LdkQMFo8tPqUqYlm+m9xYM3/+WIOU0UiZdY5O6n2oIQ0OxgTBc50AIyykye5H9zE0HHo=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-0cck.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vUnz9-00000002tvr-0Xhk
	for linux-can@vger.kernel.org;
	Sun, 14 Dec 2025 15:26:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=chDnHXzC7OmgMSvhcFfltAlCclhS52mGTR4eaadE5Jc=; b=Mle8mQFFWFofNTFGoGCzzUniSe
	pcdySQj2zcOeNOS7vf6fuKkNmIWbaMk8IOj8YrWbZY3sV+s6cJrOrkwBMAssafz67lRWqp9MRrpzM
	VLf8BNtZBVGHwVcnoXNg2P+QP/sYcfTu1paeXLrvKpxiWd7ZfUcvnnYmajBFBjgiKCGc=;
Received: from [79.34.194.176] (port=63375 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vUnyt-00000000585-3qQ7;
	Sun, 14 Dec 2025 15:25:55 +0000
Date: Sun, 14 Dec 2025 16:25:54 +0100
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
Message-ID: <aT7XAsTWr0_yyfx_@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTsE1VIk4V/A49HE@fedora>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 989eecdd16ed4abea096da28ba49d440
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vUnz9-00000002tvr-0Xhk-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-0cck.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Matias,

On Thu, Dec 11, 2025 at 06:52:21PM +0100, Matias Ezequiel Vara Larsen wrote:
> Thanks for your comments, I took most of them. I have some questions
> though. 
> 

(snip)

> > > + */
> > > +static int virtio_can_add_inbuf(struct virtqueue *vq, void *buf,
> > > +				unsigned int size)
> > > +{
> > > +	struct scatterlist sg[1];
> > > +	int ret;
> > > +
> > > +	sg_init_one(sg, buf, size);
> > > +
> > > +	ret = virtqueue_add_inbuf(vq, sg, 1, buf, GFP_ATOMIC);
> > > +	virtqueue_kick(vq);
> > > +	if (ret == 0)
> > > +		ret = vq->num_free;
> > 
> > The returned value in case of success (i.e.: vq->num_free) is not used.
> > 
> 
> I removed it this but something is not working anymore so I need to
> investigate.
>

That should't happen, since vq->num_free is defined as an unsigned int
and no caller is reacting on return values >= 0.

> > > +	return ret;
> > > +}
> > > +
> > > +/* Send a control message with message type either
> > > + *
> > > + * - VIRTIO_CAN_SET_CTRL_MODE_START or
> > > + * - VIRTIO_CAN_SET_CTRL_MODE_STOP.
> > > + *
> > > + * Unlike AUTOSAR CAN Driver Can_SetControllerMode() there is no requirement
> > > + * for this Linux driver to have an asynchronous implementation of the mode
> > > + * setting function so in order to keep things simple the function is
> > > + * implemented as synchronous function. Design pattern is
> > > + * virtio_console.c/__send_control_msg() & virtio_net.c/virtnet_send_command().
> > > + */
> > 
> > Comment is not really helpful nor informative, at least for me. I'd drop
> > the AUTOSAR part at least.
> > 
> 
> I removed it.
> 
> > > +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> > > +{
> > > +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > > +	struct virtio_can_priv *priv = netdev_priv(ndev);
> > > +	struct device *dev = &priv->vdev->dev;
> > > +	struct virtqueue *vq;
> > > +	unsigned int len;
> > > +	int err;
> > > +
> > > +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > > +
> > > +	/* The function may be serialized by rtnl lock. Not sure.
> > > +	 * Better safe than sorry.
> > > +	 */
> > > +	mutex_lock(&priv->ctrl_lock);
> > 
> > Consider the newer guard() syntax:
> > 
> >     guard(mutex)(&priv->ctrl_lock)
> > 
> 
> IIUC this adds the unlock automatically, right?
>

Yes, as soon as the function returnsi, and even in case of early
returns.

> > > +
> > > +	priv->can_ctr_msg.cpkt_out.msg_type = cpu_to_le16(msg_type);
> > > +	sg_init_one(&sg_out, &priv->can_ctr_msg.cpkt_out,
> > > +		    sizeof(priv->can_ctr_msg.cpkt_out));
> > > +	sg_init_one(&sg_in, &priv->can_ctr_msg.cpkt_in, sizeof(priv->can_ctr_msg.cpkt_in));
> > > +
> > > +	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
> > > +	if (err != 0) {
> > > +		/* Not expected to happen */
> > > +		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
> > > +		mutex_unlock(&priv->ctrl_lock);
> > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > +	}
> > > +
> > > +	if (!virtqueue_kick(vq)) {
> > > +		/* Not expected to happen */
> > > +		dev_err(dev, "%s(): Kick failed\n", __func__);
> > > +		mutex_unlock(&priv->ctrl_lock);
> > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > +	}
> > > +
> > > +	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
> > > +		wait_for_completion(&priv->ctrl_done);
> > > +
> > 
> > Since the call is synchronous, does can_ctr_msg really need to be part
> > of priv? Cannot be it allocated from the stack?
> > 
> 
> I moved it to the stack.
> 

This was a bad suggestion, as Michael S. Tsirkin suggested in another
branch of this thread [0]. Sorry.

> > > +	mutex_unlock(&priv->ctrl_lock);
> > > +
> > > +	return priv->can_ctr_msg.cpkt_in.result;
> > > +}
> > > +
> > > +static void virtio_can_start(struct net_device *ndev)
> > > +{
> > > +	struct virtio_can_priv *priv = netdev_priv(ndev);
> > > +	u8 result;
> > > +
> > > +	result = virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_START);
> > > +	if (result != VIRTIO_CAN_RESULT_OK) {
> > > +		/* Not expected to happen */
> > > +		netdev_err(ndev, "CAN controller start failed\n");
> > > +	}
> > > +
> > > +	priv->busoff_pending = false;
> > > +	priv->can.state = CAN_STATE_ERROR_ACTIVE;
> > > +
> > > +	/* Switch carrier on if device was not connected to the bus */
> > > +	if (!netif_carrier_ok(ndev))
> > > +		netif_carrier_on(ndev);
> > > +}
> > > +
> > > +/* See also m_can.c/m_can_set_mode()
> > > + *
> > > + * It is interesting that not only the M-CAN implementation but also all other
> > > + * implementations I looked into only support CAN_MODE_START.
> > > + * That CAN_MODE_SLEEP is frequently not found to be supported anywhere did not
> > > + * come not as surprise but that CAN_MODE_STOP is also never supported was one.
> > > + * The function is accessible via the method pointer do_set_mode in
> > > + * struct can_priv. As usual no documentation there.
> > > + * May not play any role as grepping through the code did not reveal any place
> > > + * from where the method is actually called.
> > > + */
> > 
> > The do_set_mode method is used e.g. to restart the CAN after a bus-off event.
> > 
> 
> Do you think we need to support CAN_MODE_STOP?
>

No, I don't think so, but the comment is somewhat misleading and feels
more like some private notes.

> > > +static int virtio_can_set_mode(struct net_device *dev, enum can_mode mode)
> > > +{
> > > +	switch (mode) {
> > > +	case CAN_MODE_START:
> > > +		virtio_can_start(dev);
> > > +		netif_wake_queue(dev);
> > > +		break;
> > > +	default:
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +

(snip)

> > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > +{
> > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > +	struct net_device *dev = can_priv->dev;
> > > +	struct virtio_can_tx *can_tx_msg;
> > > +	struct net_device_stats *stats;
> > > +	unsigned long flags;
> > > +	unsigned int len;
> > > +	u8 result;
> > > +
> > > +	stats = &dev->stats;
> > > +
> > > +	/* Protect list and virtio queue operations */
> > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > 
> > The section below seems a pretty big one to protect behind a spin lock. 
> > 
> 
> How can I split it? 
> 

Question here is: what needs to be protected? As far as I can tell, the
only entity needing some kind of locking here is the queue, while both
ida_* and tx_inflight operations are already covered (the former by
design [1], the second because it's implemented using an atomic.

If I'm not wrong (but I might be, so please double check) this can be
limited to:

	/* Protect queue operations */
	scoped_guard(spinlock_irqsave, &priv->tx_lock)
		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);


Maybe the whole locking pattern is a leftover from a previous version, 
where a list of TX messages was kept?

> > > +
> > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > +	if (!can_tx_msg) {
> > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > +		return 0; /* No more data */
> > > +	}
> > > +
> > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > +	} else {
> > > +		result = can_tx_msg->tx_in.result;
> > > +	}
> > > +

(snip)

> > > +static int virtio_can_probe(struct virtio_device *vdev)
> > > +{
> > > +	struct virtio_can_priv *priv;
> > > +	struct net_device *dev;
> > > +	int err;
> > > +
> > > +	dev = alloc_candev(sizeof(struct virtio_can_priv),
> > > +			   VIRTIO_CAN_ECHO_SKB_MAX);
> > > +	if (!dev)
> > > +		return -ENOMEM;
> > > +
> > > +	priv = netdev_priv(dev);
> > > +
> > > +	ida_init(&priv->tx_putidx_ida);
> > > +
> > > +	netif_napi_add(dev, &priv->napi, virtio_can_rx_poll);
> > > +	netif_napi_add(dev, &priv->napi_tx, virtio_can_tx_poll);
> > > +
> > > +	SET_NETDEV_DEV(dev, &vdev->dev);
> > > +
> > > +	priv->dev = dev;
> > > +	priv->vdev = vdev;
> > > +	vdev->priv = priv;
> > > +
> > > +	priv->can.do_set_mode = virtio_can_set_mode;
> > > +	/* Set Virtio CAN supported operations */
> > > +	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
> > > +	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
> > > +		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD);
> > > +		if (err != 0)
> > > +			goto on_failure;
> > > +	}
> > > +
> > > +	/* Initialize virtqueues */
> > > +	err = virtio_can_find_vqs(priv);
> > > +	if (err != 0)
> > > +		goto on_failure;
> > > +
> > > +	spin_lock_init(&priv->tx_lock);
> > > +	mutex_init(&priv->ctrl_lock);
> > > +
> > > +	init_completion(&priv->ctrl_done);
> > > +
> > > +	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD))
> > > +		priv->sdu_len = CANFD_MAX_DLEN;
> > > +	else
> > > +		priv->sdu_len = CAN_MAX_DLEN;
> > 
> > Consider replacing sdu_len with something like rpkt_len, which is
> > directly related to priv->rpkt and can make code more readable, here and
> > in other locations. E.g.:
> 
> I replaced it with rpkt_len.
> 
> > 
> > 	priv->rpkt_len = sizeof(struct virtio_can_rx);
> > 	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD))
> >     		priv->rpkt_len += CANFD_MAX_DLEN;
> > 	else
> > 		priv->rpkt_len += CAN_MAX_DLEN;
> > 
> > 	priv->rpkt = kzalloc(priv->rpkt_len * ...
> > 
> > > +
> > > +	priv->rpkt = kzalloc((sizeof(struct virtio_can_rx) + priv->sdu_len) *
> > > +						priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free,
> > > +						GFP_KERNEL);
> > 
> > If I'm not mistaken, priv->rpkt is never freed. Consider moving to
> > devm_kzalloc().
> > 
> 
> Done.
> 
> > > +	if (!priv->rpkt) {
> > > +		virtio_can_del_vq(vdev);
> > > +		goto on_failure;
> > > +	}
> > > +	virtio_can_populate_rx_vq(vdev);
> > > +
> > > +	err = register_virtio_can_dev(dev);
> > > +	if (err) {
> > > +		virtio_can_del_vq(vdev);
> > > +		goto on_failure;
> > > +	}
> > > +
> > > +	napi_enable(&priv->napi);
> > > +	napi_enable(&priv->napi_tx);
> > 
> > Most of the existing drivers enable the napi(s) during the open() phase,
> > IIUC to avoid scheduling napi operations for devices that might never
> > get used. But here maybe there is a specific reason to do it this way?
> > 
> 
> I do not have idea. I moved to open() and something stopped to work. I
> am investigating it.
>

On a second thought, it may be wiser to have the napis enabled on probe,
to drop the incoming messages even when the interface is brought down.

(last snip)


While stress testing this, I noticed that flooding the virtio-can
interface with packets leads to an hang of the interface itself.
I am seeing this issuing, at host side:

	while true; do cansend can0 123#00; done

with:

 - QEMU: the tip of the master branch plus [2]
 - vhost-device: the tip of the main branch

and the following QEMU invocation:

qemu-system-x86_64 -serial mon:stdio \
    -m 2G -smp 2 \
    -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
    -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
    -append "loglevel=7 console=ttyS0" \
    -machine memory-backend=pc.ram \
    -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
    -chardev socket,id=can0,path=/tmp/sock-can0 \
    -device vhost-user-can-pci,chardev=can0


Restarting the interface (i.e.: ip link set down and the up) does not
fix the situation.

I'll try to do some more testing during the next days.


> Thanks for reviewing it!
> 
> Matias
> 
>

Regards,
Francesco


[0] https://lore.kernel.org/linux-can/20251214022000-mutt-send-email-mst@kernel.org/
[1] https://elixir.bootlin.com/linux/v6.18.1/source/lib/idr.c#L323
[2] https://lore.kernel.org/qemu-devel/20251031155617.1223248-1-mvaralar@redhat.com/



