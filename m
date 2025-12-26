Return-Path: <linux-can+bounces-5940-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D96CDEF20
	for <lists+linux-can@lfdr.de>; Fri, 26 Dec 2025 20:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DC36300478D
	for <lists+linux-can@lfdr.de>; Fri, 26 Dec 2025 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0324677D;
	Fri, 26 Dec 2025 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJuOYNsv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o2Tm0WFG"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A371F4615
	for <linux-can@vger.kernel.org>; Fri, 26 Dec 2025 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766778361; cv=none; b=BQuSjGkdIfAaiSc8UT6Mv7j0KN2utQitQlIZFq3ca2m96fjsqtIz6bTg9+aC1qJOKdXzLZNK8I+2z432e4fa6TTN/JeK5WyxAO7+loMcxPL1uq5hC+tCIbEdhhb0O0312LlaSZUFHUDYPLkYCwsih1IsKxeohN0V4raM94XdHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766778361; c=relaxed/simple;
	bh=wVYZF+e1enXNKGfJjuWosy6NKBwBgoZ3nbZt6jDkl1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1pSDX5uxYMFbq1OPvqalB+IM6bLGb0qCf1gQLV/u+qWO1Dj8UveJ0dLNfGx/pmtGXwm2AbnUgfLxMdqxlu1Rcci2Q0HjgbdxD1TT0+Sx3irKQc6pkNSMEU9e4rXP0AC/Nct3gUC37tFYsPD593mqJ4H/D0yt+OmDK9KuFp31RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJuOYNsv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o2Tm0WFG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766778358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3ANcrzYPkDIAnFUIilXfbPnAAM7NCYeWzEM7/NuXJ8=;
	b=UJuOYNsveKOVTBCaR+K5Pcje5FHK8bGOk9hNnZhvlOBzVkhl+zswLNX5z3KkzSl+yBokFw
	qtEAr6Cx+FosuhTcSiZiPbp8nIvUdtVl8TOxXWvAGESnrxxbfu7HBEOOT/kn+Ofxk1/3NZ
	/XBtwzIedq1MBCupZCyTk/wO9yc5bOI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-g5bQG8Y8MCemjxJ5bj6qhQ-1; Fri, 26 Dec 2025 14:45:57 -0500
X-MC-Unique: g5bQG8Y8MCemjxJ5bj6qhQ-1
X-Mimecast-MFC-AGG-ID: g5bQG8Y8MCemjxJ5bj6qhQ_1766778356
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f1f69eec6so95904015ad.1
        for <linux-can@vger.kernel.org>; Fri, 26 Dec 2025 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766778356; x=1767383156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3ANcrzYPkDIAnFUIilXfbPnAAM7NCYeWzEM7/NuXJ8=;
        b=o2Tm0WFGhK/PlqswJBYaNgM73sXa2ZoSmx/Fk3RTKROBlfP5raQQ7ArCNkkCNWck4b
         BEmIK954PmLenc8SsGm68ymMiGtHivCCMrvaIBFxu2HbujEu0db4VAsckdm9b26DFKzF
         aJiriHTKTFRuV1ZT6a50LjbOtKlaUm6/KloVKx/H6YsEtf2IM269cw8/5qqX9OKWnGMJ
         uL9Cm36s/r6hDwqTFs2dBv3W2dK0k3kq0taj76iDdUNgrXtrb49weYpv8I8y32spz46E
         WYxGB+neulenaTnPLYpVmPMpjYmswg8P0GBXU9X0Z6y7iIXh7rXx6a3d8RNBa8YHu4NY
         zHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766778356; x=1767383156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3ANcrzYPkDIAnFUIilXfbPnAAM7NCYeWzEM7/NuXJ8=;
        b=M8x/CYdbrXARI2OEiCULGevyXcPBrms9FhMMtxLuSsJjNj/TymAwVSSSbUAm3fLY3F
         THhctx31lkk70JGSn73+aNlwEP5QtI2XhCxUhTZ/msshixKDoxUdc9+02++ZygQYgwYh
         FXt3sdI6mQ0Q+ySfThsrDDWOyc3Vl6XOG0kEvcWebJG2ykvabhQYWiE043VZ45UFh2XY
         7B5Ti+4aY3o92YydMhZT5S5uzYgsJizJqejznSL18Aw1ufb5hUkNcwsgOVZgexRfZCTA
         2dVe+5w7rCj8xgxyBsRqsC/UvT4BITf79jL1PjqpXSnwwF644mW3eSlBA7TkYUwQehao
         Icog==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+FLqzA7svMDf3SJXfFlGy0piNvsYW+x+Osf0V0+xovT+Ny1+0o4jtLLswlBOnaNg88Dynw7gJeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvFmVBFD6DTsmawYtsDYVmy+LnnB7xUMnIFOdw3SDWKqeAQkq
	1vUaoMB+ARss4HRMqpPuoK6LB63tyiAkHTpa1VC4sVCqD+hO7yNqcRt+7b8GnyArPwWvBnQN1RN
	V9QDzIhmaewDe6M3FLwZPa4VAlBJLgxRMmYepmRds/DvSeqSImH5EJWmNnmOo8Q==
X-Gm-Gg: AY/fxX7xmH1569BJRd7CS4onWokmH3W4upJssqHVwV1K5a4viLaMv6jJ/yd38sND754
	EI3YNK0aYgaktV7s5D30WEoGicUXLSJW+vvwoe1PZhhOAINmhgG6NOiYIroItonq8oTd74LvGiL
	OiKjcCP9tAfgrqA33I96dnSlKRPP+Jnsjhxz9Uvi2aP34cV1DgJDL1QrfshrWzZtP+Dab8QIVJ7
	wB6baNEKaaE/9Jvd2SRA30AM13Mxu2SHjboU7rRDHZec2igVdXhprKNoJ4V2Pss8SYbKYjTKE7r
	zZRska5BLmnEYPFGFF7CyORvM6JAtM9kKkjKVzhWKkQLC9+gRgXq5wniaOtlQXt/9RZbWgPDYQw
	l3MQoejqoOcOKWZhzJ9QHsZj+Mi+tZ+rLmEMSyIZjizWyA6Y=
X-Received: by 2002:a05:7022:b906:b0:11b:c86b:386a with SMTP id a92af1059eb24-121722abe20mr17088377c88.5.1766778355821;
        Fri, 26 Dec 2025 11:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMCubugbb6ViKIrXyUFk2mh7Euous4RdnMGFJwHZM5vXOJfaFiwdvfWBHf4PMCa4VGZrJbcg==
X-Received: by 2002:a05:7022:b906:b0:11b:c86b:386a with SMTP id a92af1059eb24-121722abe20mr17088352c88.5.1766778355195;
        Fri, 26 Dec 2025 11:45:55 -0800 (PST)
Received: from fedora (pinamar-179-51-86-121.users.telpin.com.ar. [179.51.86.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm102034332c88.12.2025.12.26.11.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 11:45:54 -0800 (PST)
Date: Fri, 26 Dec 2025 20:45:48 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Francesco Valla <francesco@valla.it>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
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
Message-ID: <aU7l7MckMumCxmeQ@fedora>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <23c5df0c-48d1-4d3a-8f25-8249b93c9b60@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c5df0c-48d1-4d3a-8f25-8249b93c9b60@oss.qualcomm.com>

On Thu, Dec 18, 2025 at 08:51:41PM +0100, Harald Mommer wrote:
> Hello,
> 
> On 12/14/25 16:25, Francesco Valla wrote:
> 
> >>>> +/* Compare with m_can.c/m_can_echo_tx_event() */
> 
> For the question whether some comments were originally more personal notes: Yes!
> 
> This applies especially for the ones which state in which already accepted driver(s) was looked to get an idea how things may be expected to be done. Most of those comments should have served their purpose now.
> 
> >>>> +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> >>>> +{
> >>>> +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> >>>> +	struct net_device *dev = can_priv->dev;
> >>>> +	struct virtio_can_tx *can_tx_msg;
> >>>> +	struct net_device_stats *stats;
> >>>> +	unsigned long flags;
> >>>> +	unsigned int len;
> >>>> +	u8 result;
> >>>> +
> >>>> +	stats = &dev->stats;
> >>>> +
> >>>> +	/* Protect list and virtio queue operations */
> >>>> +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> >>>
> >>> The section below seems a pretty big one to protect behind a spin lock. 
> >>>
> >>
> >> How can I split it? 
> >>
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
> 
> 1.) There is virtqueue_get_buf() => virtqueue_get_buf_ctx() and there is a comment 
> " * Caller must ensure we don't call this with other virtqueue
>   * operations at the same time (except where noted)."
> 
> Are we safe when at the same time in virtio_can_start_xmit() a queue operation is done in parallel?
> 
> Locking may or may not be necessary here. I cannot tell in this moment.
> 
> 2.) There was once a "list_del(&can_tx_msg->list);" in the code here. 
> 
> When in virtio_can_start_xmit() at the same time a list_add_tail() or a list_del() would have been executed we had a garbled linked list.
> 
> The linked list now does not exist any more in the newer code base.
> 
> => could be that the lock is not needed any more at all
> => could be that we have to protect only the queue operations now and this would shorten the locking time and simplify the code
> 
> >>>> +
> >>>> +	can_tx_msg = virtqueue_get_buf(vq, &len);
> >>>> +	if (!can_tx_msg) {
> >>>> +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> >>>> +		return 0; /* No more data */
> >>>> +	}
> >>>> +
> >>>> +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> >>>> +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> >>>> +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> >>>> +	} else {
> >>>> +		result = can_tx_msg->tx_in.result;
> >>>> +	}
> >>>> +
> > 
> > (snip)
> > 
> 
> >>>> +	if (!priv->rpkt) {
> >>>> +		virtio_can_del_vq(vdev);
> >>>> +		goto on_failure;
> >>>> +	}
> >>>> +	virtio_can_populate_rx_vq(vdev);
> >>>> +
> >>>> +	err = register_virtio_can_dev(dev);
> >>>> +	if (err) {
> >>>> +		virtio_can_del_vq(vdev);
> >>>> +		goto on_failure;
> >>>> +	}
> >>>> +
> >>>> +	napi_enable(&priv->napi);
> >>>> +	napi_enable(&priv->napi_tx);
> >>>
> >>> Most of the existing drivers enable the napi(s) during the open() phase,
> >>> IIUC to avoid scheduling napi operations for devices that might never
> >>> get used. But here maybe there is a specific reason to do it this way?
> >>>
> >>
> >> I do not have idea. I moved to open() and something stopped to work. I
> >> am investigating it.
> >>
> > 
> > On a second thought, it may be wiser to have the napis enabled on probe,
> > to drop the incoming messages even when the interface is brought down.
> 
> It's a while since then but I wanted to drop messages not having lurking a 3 hours old cooling water temperature in some virtio message buffer being misinterpreted as an actual value. May have the disadvantage to cause load when the driver is not open-ed. But I see you also thought about 3 hours old outdated values now which may cause trouble.
> 

I see, so if napis is enabled on probe(), messages would be dropped
until open() thus preventing old messages to be read a new ones. Am I
right? In that case, I would move back the enablement of napis to probe().


> > 
> > (last snip)
> > 
> > 
> > While stress testing this, I noticed that flooding the virtio-can
> > interface with packets leads to an hang of the interface itself.
> > I am seeing this issuing, at host side:
> > 
> > 	while true; do cansend can0 123#00; done
> > 
> > with:
> > 
> >  - QEMU: the tip of the master branch plus [2]
> >  - vhost-device: the tip of the main branch
> > 
> > and the following QEMU invocation:
> > 
> > qemu-system-x86_64 -serial mon:stdio \
> >     -m 2G -smp 2 \
> >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> >     -append "loglevel=7 console=ttyS0" \
> >     -machine memory-backend=pc.ram \
> >     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
> >     -chardev socket,id=can0,path=/tmp/sock-can0 \
> >     -device vhost-user-can-pci,chardev=can0
> 
> I had this problem when I enabled the experimental feature late TX ACK on the device side instead of immediately sending the TX ack early even when the CAN message had not yet been transmitted on the (physical) bus. In this case I relied that no ACK message (own sent message received) was lost otherwise I ran out of messages in the transmit queue everything waiting until doomsday for ACKs which would never come.
> 
> The problem was that somewhere in the Linux stack those acknowledgements got lost under heavy load on the device side. Workaround was to ack the TX message early (means putting the message immediately back into the used queue when received) in the virtio device. But this is a device thing, the device MUST put back ALL messages back into the used queue not forgetting about some under whatever circumstances otherwise the avail queue will get empty forever.
> 
> Besides that I could do what I want stressing the code and it did not stop. But this code was different from what I see now, and the testing environment was also a different one. 
> 
> > Restarting the interface (i.e.: ip link set down and the up) does not
> > fix the situation.
> > 
> > I'll try to do some more testing during the next days.
> Other than fixing the swapped feature flag values for the next release internally I've had not yet the chance to look deeply into all those changes and really to think about them in depth.
> 
> 


