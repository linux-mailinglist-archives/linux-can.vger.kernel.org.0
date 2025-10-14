Return-Path: <linux-can+bounces-5179-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76961BD8B4F
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 12:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A453AF5C1
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3FB2E8B71;
	Tue, 14 Oct 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiHzu7Rj"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EB2F28F0
	for <linux-can@vger.kernel.org>; Tue, 14 Oct 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436922; cv=none; b=tfTBiysB6dV81hkExIximTr60a9hBPT5Bx4DXha6UIQxbFO3N+ctr7rZ0w9g4AYHTcO5YSmyMkst05/fByWFZyiCxFKuKfchuN53eNyLBhDqI9U2nxWq0fQsb02aVVLCxkX3SSkjBTLJguedUkf+pxbvbf/gQtbR/EvXcDOVmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436922; c=relaxed/simple;
	bh=NwcckHy8o9d7dQH0xLue2IE8AkT8Ch5YfNOzsyUfxZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMkM1K3sP8dNX0ISBVQzDPBRIBrH5rgMByYJQw01V7oGmVcbCw1Dgh4PWudwrM+N3FFCs4qLb8+YkP3gxHl5d5j6w817z5FwlTNX1OjR9VsNf2OUFt+4Ot4IkCoxjglMryU5XYuyPe2gEjK+79eCAazBFkp5oY7mUp1P/PWBmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WiHzu7Rj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760436918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10BGsZqBfx67gqRETn13bNS/Puo4azPAw3HcckQ2HC8=;
	b=WiHzu7RjHLVfu7pZOWSuwK8pSpi5ZnAortJRE3/T007uEqsK42izdtczbJet5SNU+cd59j
	iXzk6Xu4D111v2IOw4ZE/0jzFeEdBVOcgtbZHHDh8fzMpG+1m5fiGrL87CzrWKXvZW4i7I
	G3zV0ifSAzTco035YW1ssox6nyvlPew=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-JWB5slFEMPGp8XkI8p_g_A-1; Tue, 14 Oct 2025 06:15:17 -0400
X-MC-Unique: JWB5slFEMPGp8XkI8p_g_A-1
X-Mimecast-MFC-AGG-ID: JWB5slFEMPGp8XkI8p_g_A_1760436916
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso4204522f8f.2
        for <linux-can@vger.kernel.org>; Tue, 14 Oct 2025 03:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436916; x=1761041716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10BGsZqBfx67gqRETn13bNS/Puo4azPAw3HcckQ2HC8=;
        b=qCA/d0llMm1UdNIAvqKqxgBOBVS3dMpE2Pu2n7+5hQBys3mhPRpM9YP1+xSfRQnn8N
         m0vOU/we8adFRRFinOcnc4aifycb0K1Ruk5j5SXtjr5RxMx4YnLkv1BPSAHZa+IQoRuq
         dsEZJBf/407o7vnCE0kkl2yg/6x+DiCWQ7XLaewUTQIujQFoyzhSoEmicxPTVpaL7VCp
         Wnp1sY2S7rynCoRBImoucF1E4avWFqP8p/o/EZE0JEMFAGG6SGD7DN6xH/GqWFqHtm5r
         PvpbrBVZ4yYcCY5Y/xuf9+MLmBJQuuu4WtcAF+TIcClyJyBi8KwJsdeowJ11pz2JG5Dx
         pyVg==
X-Forwarded-Encrypted: i=1; AJvYcCWZDOAZNFM0AJk5CMj13IWTCtV0jTu6LDgQr9rei4n/RFgzKv6aPgs34ZpwSRwLkYX+oDvGOaI+jJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBN9/lZdwBhezhWfmMzffL5BT1MyT3Dcj99cwQ9OluDTzH8uU
	tlqv8K1vBWf2Zlp0VFH3MS2mF8/jrn7O/5pA45uFgD9owwxPrh6lkVSffSPEJnaG7DeXvW/Yz+Y
	U4me2HWVVOIQG+bm5E6eta3t/4X1ZLtg+8sMRUtKJw4HKamldMR85zE2/+67cHQ==
X-Gm-Gg: ASbGncuH9toekgVI28rQ56Xp+lwpW1HYwpyafHzvszz7LmNOnDhuxAa76EIoH+ARFib
	wJMmNZ7zYQL8/JLqBeh2ChvtylZIAoWJmg2yIVMnadxNxEH1YN0VHCjx+57FppjgdfafjUpgAGj
	FZYbLk1vzM6ELAFLhiKjsIE0WCPtMOLCpMtutIr+FtVtHbyGVanPEYsJBJ43rWdX06lE4dV1pz2
	vu9Q5Uuv+earXm/PYvVxVya/7Okq/ykN7OmKFcf9B1YeNQXxsTvrYMQK7wR2cpm3EHIY9/A0wbm
	q4reJEFQp+9UFlRbTZJwvv2vO1ZkKLXOAQ==
X-Received: by 2002:a05:6000:1a87:b0:3ee:b126:6b6 with SMTP id ffacd0b85a97d-4266e7dfee2mr14270099f8f.34.1760436915693;
        Tue, 14 Oct 2025 03:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeRwgZHxensKDf9pyRs4j2o5BaQIKepX/rgZHfU4bLxsJ0FWDug2Sf3lPEReohX5TG1I2+6g==
X-Received: by 2002:a05:6000:1a87:b0:3ee:b126:6b6 with SMTP id ffacd0b85a97d-4266e7dfee2mr14270064f8f.34.1760436915116;
        Tue, 14 Oct 2025 03:15:15 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57ccb1sm22821362f8f.8.2025.10.14.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:15:14 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:15:12 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aO4isIfRbgKuCvRX@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2243144.yiUUSuA9gR@fedora.fritz.box>

On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> Hello Mikhail, Harald,
> 
> hoping there will be a v6 of this patch soon, a few comments:
> 
> On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> 
> [...]
> 
> > +
> > +/* virtio_can private data structure */
> > +struct virtio_can_priv {
> > +	struct can_priv can;	/* must be the first member */
> > +	/* NAPI for RX messages */
> > +	struct napi_struct napi;
> > +	/* NAPI for TX messages */
> > +	struct napi_struct napi_tx;
> > +	/* The network device we're associated with */
> > +	struct net_device *dev;
> > +	/* The virtio device we're associated with */
> > +	struct virtio_device *vdev;
> > +	/* The virtqueues */
> > +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> > +	/* I/O callback function pointers for the virtqueues */
> > +	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
> > +	/* Lock for TX operations */
> > +	spinlock_t tx_lock;
> > +	/* Control queue lock. Defensive programming, may be not needed */
> > +	struct mutex ctrl_lock;
> > +	/* Wait for control queue processing without polling */
> > +	struct completion ctrl_done;
> > +	/* List of virtio CAN TX message */
> > +	struct list_head tx_list;
> > +	/* Array of receive queue messages */
> > +	struct virtio_can_rx rpkt[128];
> 
> This array should probably be allocated dynamically at probe - maybe
> using a module parameter instead of a hardcoded value as length? 
> 
> > +	/* Those control queue messages cannot live on the stack! */
> > +	struct virtio_can_control_out cpkt_out;
> > +	struct virtio_can_control_in cpkt_in;
> 
> Consider using a container struct as you did for the tx message, e.g.:
> 
> struct virtio_can_control {
> 	struct virtio_can_control_out ctrl_out;
> 	struct virtio_can_control_in ctrl_in;
> };
> 
> > +	/* Data to get and maintain the putidx for local TX echo */
> > +	struct ida tx_putidx_ida;
> > +	/* In flight TX messages */
> > +	atomic_t tx_inflight;
> > +	/* BusOff pending. Reset after successful indication to upper layer */
> > +	bool busoff_pending;
> > +};
> > +
> 
> [...]
> 
> > +
> > +/* Send a control message with message type either
> > + *
> > + * - VIRTIO_CAN_SET_CTRL_MODE_START or
> > + * - VIRTIO_CAN_SET_CTRL_MODE_STOP.
> > + *
> > + * Unlike AUTOSAR CAN Driver Can_SetControllerMode() there is no requirement
> > + * for this Linux driver to have an asynchronous implementation of the mode
> > + * setting function so in order to keep things simple the function is
> > + * implemented as synchronous function. Design pattern is
> > + * virtio_console.c/__send_control_msg() & virtio_net.c/virtnet_send_command().
> > + */
> > +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> > +{
> > +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > +	struct virtio_can_priv *priv = netdev_priv(ndev);
> > +	struct device *dev = &priv->vdev->dev;
> > +	struct virtqueue *vq;
> > +	unsigned int len;
> > +	int err;
> > +
> > +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > +
> > +	/* The function may be serialized by rtnl lock. Not sure.
> > +	 * Better safe than sorry.
> > +	 */
> > +	mutex_lock(&priv->ctrl_lock);
> > +
> > +	priv->cpkt_out.msg_type = cpu_to_le16(msg_type);
> > +	sg_init_one(&sg_out, &priv->cpkt_out, sizeof(priv->cpkt_out));
> > +	sg_init_one(&sg_in, &priv->cpkt_in, sizeof(priv->cpkt_in));
> > +
> > +	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
> > +	if (err != 0) {
> > +		/* Not expected to happen */
> > +		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
> > +	}
> 
> Here it should return VIRTIO_CAN_RESULT_NOT_OK after unlocking the
> mutex, or it might wait for completion indefinitley below.
> 
> > +
> > +	if (!virtqueue_kick(vq)) {
> > +		/* Not expected to happen */
> > +		dev_err(dev, "%s(): Kick failed\n", __func__);
> > +	}
> 
> And here too.
> 
> > +
> > +	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
> > +		wait_for_completion(&priv->ctrl_done);
> > +
> > +	mutex_unlock(&priv->ctrl_lock);
> > +
> > +	return priv->cpkt_in.result;
> > +}
> > +
> 
> [...]
> 
> > +static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
> > +					 struct net_device *dev)
> > +{
> > +	const unsigned int hdr_size = offsetof(struct virtio_can_tx_out, sdu);
> > +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > +	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> > +	struct virtio_can_priv *priv = netdev_priv(dev);
> > +	netdev_tx_t xmit_ret = NETDEV_TX_OK;
> > +	struct virtio_can_tx *can_tx_msg;
> > +	struct virtqueue *vq;
> > +	unsigned long flags;
> > +	u32 can_flags;
> > +	int putidx;
> > +	int err;
> > +
> > +	vq = priv->vqs[VIRTIO_CAN_QUEUE_TX];
> > +
> > +	if (can_dev_dropped_skb(dev, skb))
> > +		goto kick; /* No way to return NET_XMIT_DROP here */
> > +
> > +	/* No local check for CAN_RTR_FLAG or FD frame against negotiated
> > +	 * features. The device will reject those anyway if not supported.
> > +	 */
> > +
> > +	can_tx_msg = kzalloc(sizeof(*can_tx_msg), GFP_ATOMIC);
> > +	if (!can_tx_msg) {
> > +		dev->stats.tx_dropped++;
> > +		goto kick; /* No way to return NET_XMIT_DROP here */
> > +	}
> > +
> 
> Since we are allocating tx messages dynamically, the sdu[64] array inside
> struct virtio_can_tx_out can be converted to a flexible array and here
> the allocation can become:
> 
> 	can_tx_msg = kzalloc(sizeof(*can_tx_msg) + cf->len, GFP_ATOMIC);
> 
> This would save memory in particular on CAN-CC interfaces, where 56 bytes
> per message would otherwise be lost (not to mention the case if/when
> CAN-XL will be supported).
> 
> > +	can_tx_msg->tx_out.msg_type = cpu_to_le16(VIRTIO_CAN_TX);
> > +	can_flags = 0;
> > +
> > +	if (cf->can_id & CAN_EFF_FLAG) {
> > +		can_flags |= VIRTIO_CAN_FLAGS_EXTENDED;
> > +		can_tx_msg->tx_out.can_id = cpu_to_le32(cf->can_id & CAN_EFF_MASK);
> > +	} else {
> > +		can_tx_msg->tx_out.can_id = cpu_to_le32(cf->can_id & CAN_SFF_MASK);
> > +	}
> > +	if (cf->can_id & CAN_RTR_FLAG)
> > +		can_flags |= VIRTIO_CAN_FLAGS_RTR;
> > +	else
> > +		memcpy(can_tx_msg->tx_out.sdu, cf->data, cf->len);
> > +	if (can_is_canfd_skb(skb))
> > +		can_flags |= VIRTIO_CAN_FLAGS_FD;
> > +
> > +	can_tx_msg->tx_out.flags = cpu_to_le32(can_flags);
> > +	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
> > +
> > +	/* Prepare sending of virtio message */
> > +	sg_init_one(&sg_out, &can_tx_msg->tx_out, hdr_size + cf->len);
> > +	sg_init_one(&sg_in, &can_tx_msg->tx_in, sizeof(can_tx_msg->tx_in));
> > +
> > +	putidx = virtio_can_alloc_tx_idx(priv);
> > +
> > +	if (unlikely(putidx < 0)) {
> > +		/* -ENOMEM or -ENOSPC here. -ENOSPC should not be possible as
> > +		 * tx_inflight >= can.echo_skb_max is checked in flow control
> > +		 */
> > +		WARN_ON_ONCE(putidx == -ENOSPC);
> > +		kfree(can_tx_msg);
> > +		dev->stats.tx_dropped++;
> > +		goto kick; /* No way to return NET_XMIT_DROP here */
> > +	}
> > +
> > +	can_tx_msg->putidx = (unsigned int)putidx;
> > +
> > +	/* Protect list operation */
> > +	spin_lock_irqsave(&priv->tx_lock, flags);
> > +	list_add_tail(&can_tx_msg->list, &priv->tx_list);
> > +	spin_unlock_irqrestore(&priv->tx_lock, flags);
> > +
> > +	/* Push loopback echo. Will be looped back on TX interrupt/TX NAPI */
> > +	can_put_echo_skb(skb, dev, can_tx_msg->putidx, 0);
> > +
> > +	/* Protect queue and list operations */
> > +	spin_lock_irqsave(&priv->tx_lock, flags);
> > +	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
> > +	if (unlikely(err)) { /* checking vq->num_free in flow control */
> > +		list_del(&can_tx_msg->list);
> > +		can_free_echo_skb(dev, can_tx_msg->putidx, NULL);
> > +		virtio_can_free_tx_idx(priv, can_tx_msg->putidx);
> > +		spin_unlock_irqrestore(&priv->tx_lock, flags);
> > +		netif_stop_queue(dev);
> > +		kfree(can_tx_msg);
> > +		/* Expected never to be seen */
> > +		netdev_warn(dev, "TX: Stop queue, err = %d\n", err);
> > +		xmit_ret = NETDEV_TX_BUSY;
> > +		goto kick;
> > +	}
> > +
> > +	/* Normal flow control: stop queue when no transmission slots left */
> > +	if (atomic_read(&priv->tx_inflight) >= priv->can.echo_skb_max ||
> > +	    vq->num_free == 0 || (vq->num_free < ARRAY_SIZE(sgs) &&
> > +	    !virtio_has_feature(vq->vdev, VIRTIO_RING_F_INDIRECT_DESC))) {
> > +		netif_stop_queue(dev);
> > +		netdev_dbg(dev, "TX: Normal stop queue\n");
> > +	}
> > +
> > +	spin_unlock_irqrestore(&priv->tx_lock, flags);
> > +
> > +kick:
> > +	if (netif_queue_stopped(dev) || !netdev_xmit_more()) {
> > +		if (!virtqueue_kick(vq))
> > +			netdev_err(dev, "%s(): Kick failed\n", __func__);
> > +	}
> > +
> > +	return xmit_ret;
> > +}
> > +
> > +static const struct net_device_ops virtio_can_netdev_ops = {
> > +	.ndo_open = virtio_can_open,
> > +	.ndo_stop = virtio_can_close,
> > +	.ndo_start_xmit = virtio_can_start_xmit,
> > +	.ndo_change_mtu = can_change_mtu,
> > +};
> > +
> > +static int register_virtio_can_dev(struct net_device *dev)
> > +{
> > +	dev->flags |= IFF_ECHO;	/* we support local echo */
> > +	dev->netdev_ops = &virtio_can_netdev_ops;
> > +
> > +	return register_candev(dev);
> > +}
> > +
> > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > +{
> > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > +	struct net_device *dev = can_priv->dev;
> > +	struct virtio_can_tx *can_tx_msg;
> > +	struct net_device_stats *stats;
> > +	unsigned long flags;
> > +	unsigned int len;
> > +	u8 result;
> > +
> > +	stats = &dev->stats;
> > +
> > +	/* Protect list and virtio queue operations */
> > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > +
> > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > +	if (!can_tx_msg) {
> > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > +		return 0; /* No more data */
> > +	}
> > +
> > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > +	} else {
> > +		result = can_tx_msg->tx_in.result;
> > +	}
> > +
> > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > +		 * echoed. Intentional to bring a waiting process in an upper
> > +		 * layer to an end.
> > +		 * TODO: Any better means to indicate a problem here?
> > +		 */
> > +		if (result != VIRTIO_CAN_RESULT_OK)
> > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> 
> Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> 
I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
a problem in the rx path and this is the tx path. I think the comment
refers to improving the way the driver informs this error to the user
but I may be wrong.

> For sure, counting the known errors as valid tx_packets and tx_bytes
> is misleading.
> 

I'll remove the counters below.

> > +
> > +		stats->tx_bytes += can_get_echo_skb(dev, can_tx_msg->putidx,
> > +						    NULL);
> > +		stats->tx_packets++;
> > +	} else {
> > +		netdev_dbg(dev, "TX ACK: Controller inactive, drop echo\n");
> > +		can_free_echo_skb(dev, can_tx_msg->putidx, NULL);
> > +	}
> > +
> > +	list_del(&can_tx_msg->list);
> > +	virtio_can_free_tx_idx(can_priv, can_tx_msg->putidx);
> > +
> > +	/* Flow control */
> > +	if (netif_queue_stopped(dev)) {
> > +		netdev_dbg(dev, "TX ACK: Wake up stopped queue\n");
> > +		netif_wake_queue(dev);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > +
> > +	kfree(can_tx_msg);
> > +
> > +	return 1; /* Queue was not empty so there may be more data */
> > +}
> > +
> 
> [...]
> 
> > +
> > +static int virtio_can_find_vqs(struct virtio_can_priv *priv)
> > +{
> > +	/* The order of RX and TX is exactly the opposite as in console and
> > +	 * network. Does not play any role but is a bad trap.
> > +	 */
> > +	static const char * const io_names[VIRTIO_CAN_QUEUE_COUNT] = {
> > +		"can-tx",
> > +		"can-rx",
> > +		"can-state-ctrl"
> > +	};
> > +
> > +	priv->io_callbacks[VIRTIO_CAN_QUEUE_TX] = virtio_can_tx_intr;
> > +	priv->io_callbacks[VIRTIO_CAN_QUEUE_RX] = virtio_can_rx_intr;
> > +	priv->io_callbacks[VIRTIO_CAN_QUEUE_CONTROL] = virtio_can_control_intr;
> > +
> > +	/* Find the queues. */
> > +	return virtio_find_vqs(priv->vdev, VIRTIO_CAN_QUEUE_COUNT, priv->vqs,
> > +			       priv->io_callbacks, io_names, NULL);
> > +}
> 
> Syntax of virtio_find_vqs changed a bit, here should now be:
> 
> 	struct virtqueue_info vqs_info[] = {
> 		{ "can-tx", virtio_can_tx_intr },
> 		{ "can-rx", virtio_can_rx_intr },
> 		{ "can-state-ctrl", virtio_can_control_intr },
> 	};
> 
> 	return virtio_find_vqs(priv->vdev, VIRTIO_CAN_QUEUE_COUNT, priv->vqs,
> 			  vqs_info, NULL);
> 
> > +
> > +/* Function must not be called before virtio_can_find_vqs() has been run */
> > +static void virtio_can_del_vq(struct virtio_device *vdev)
> > +{
> > +	struct virtio_can_priv *priv = vdev->priv;
> > +	struct list_head *cursor, *next;
> > +	struct virtqueue *vq;
> > +
> > +	/* Reset the device */
> > +	if (vdev->config->reset)
> > +		vdev->config->reset(vdev);
> > +
> > +	/* From here we have dead silence from the device side so no locks
> > +	 * are needed to protect against device side events.
> > +	 */
> > +
> > +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > +	while (virtqueue_detach_unused_buf(vq))
> > +		; /* Do nothing, content allocated statically */
> > +
> > +	vq = priv->vqs[VIRTIO_CAN_QUEUE_RX];
> > +	while (virtqueue_detach_unused_buf(vq))
> > +		; /* Do nothing, content allocated statically */
> > +
> > +	vq = priv->vqs[VIRTIO_CAN_QUEUE_TX];
> > +	while (virtqueue_detach_unused_buf(vq))
> > +		; /* Do nothing, content to be de-allocated separately */
> > +
> > +	/* Is keeping track of allocated elements by an own linked list
> > +	 * really necessary or may this be optimized using only
> > +	 * virtqueue_detach_unused_buf()?
> > +	 */
> > +	list_for_each_safe(cursor, next, &priv->tx_list) {
> > +		struct virtio_can_tx *can_tx;
> > +
> > +		can_tx = list_entry(cursor, struct virtio_can_tx, list);
> > +		list_del(cursor);
> > +		kfree(can_tx);
> > +	}
> 
> I'd drop the tx_list entirely and rely on virtqueue_detach_unused_buf();
> this would allow to remove at least one spinlock save/restore pair at
> each transmission. 
> 
> > +
> > +	if (vdev->config->del_vqs)
> > +		vdev->config->del_vqs(vdev);
> > +}
> > +
> 
> [...]
> 
> > diff --git a/include/uapi/linux/virtio_can.h b/include/uapi/linux/virtio_can.h
> > new file mode 100644
> > index 000000000000..7cf613bb3f1a
> > --- /dev/null
> > +++ b/include/uapi/linux/virtio_can.h
> > @@ -0,0 +1,75 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause */
> > +/*
> > + * Copyright (C) 2021-2023 OpenSynergy GmbH
> > + */
> > +#ifndef _LINUX_VIRTIO_VIRTIO_CAN_H
> > +#define _LINUX_VIRTIO_VIRTIO_CAN_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/virtio_types.h>
> > +#include <linux/virtio_ids.h>
> > +#include <linux/virtio_config.h>
> > +
> > +/* Feature bit numbers */
> > +#define VIRTIO_CAN_F_CAN_CLASSIC        0
> > +#define VIRTIO_CAN_F_CAN_FD             1
> > +#define VIRTIO_CAN_F_LATE_TX_ACK        2
> > +#define VIRTIO_CAN_F_RTR_FRAMES         3
> > +
> 
> The values for VIRTIO_CAN_F_LATE_TX_ACK and VIRTIO_CAN_F_RTR_FRAMES are
> inverted w.r.t. the merged virto-can spec [1].
> 
> Note that this is the only deviation from the spec I found.
> 
> > +/* CAN Result Types */
> > +#define VIRTIO_CAN_RESULT_OK            0
> > +#define VIRTIO_CAN_RESULT_NOT_OK        1
> > +
> > +/* CAN flags to determine type of CAN Id */
> > +#define VIRTIO_CAN_FLAGS_EXTENDED       0x8000
> > +#define VIRTIO_CAN_FLAGS_FD             0x4000
> > +#define VIRTIO_CAN_FLAGS_RTR            0x2000
> > +
> > +struct virtio_can_config {
> > +#define VIRTIO_CAN_S_CTRL_BUSOFF (1u << 0) /* Controller BusOff */
> > +	/* CAN controller status */
> > +	__le16 status;
> > +};
> > +
> > +/* TX queue message types */
> > +struct virtio_can_tx_out {
> > +#define VIRTIO_CAN_TX                   0x0001
> > +	__le16 msg_type;
> > +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > +	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > +	__u8 padding;
> > +	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > +	__le32 flags;
> > +	__le32 can_id;
> > +	__u8 sdu[64];
> > +};
> > +
> 
> sdu[] here might be a flexible array, if the driver allocates
> virtio_can_tx_out structs dyncamically (see above). This would be
> beneficial in case of CAN-XL frames (if/when they will be supported).
> 
> > +struct virtio_can_tx_in {
> > +	__u8 result;
> > +};
> > +
> > +/* RX queue message types */
> > +struct virtio_can_rx {
> > +#define VIRTIO_CAN_RX                   0x0101
> > +	__le16 msg_type;
> > +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > +	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > +	__u8 padding;
> > +	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > +	__le32 flags;
> > +	__le32 can_id;
> > +	__u8 sdu[64];
> > +};
> > +
> 
> Again, sdu[] might be a flexible array.
> 
> > +/* Control queue message types */
> > +struct virtio_can_control_out {
> > +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
> > +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
> > +	__le16 msg_type;
> > +};
> > +
> > +struct virtio_can_control_in {
> > +	__u8 result;
> > +};
> > +
> > +#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_CAN_H */
> > 
> 
> Thank you for your work!
> 
> Regards,
> Francesco
> 
> 
> [1] https://github.com/oasis-tcs/virtio-spec/blob/virtio-1.4/device-types/can/description.tex#L45
> 
> 
> 
> 


