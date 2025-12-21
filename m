Return-Path: <linux-can+bounces-5891-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1BECD406F
	for <lists+linux-can@lfdr.de>; Sun, 21 Dec 2025 14:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B61E030065B5
	for <lists+linux-can@lfdr.de>; Sun, 21 Dec 2025 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DFF2FC009;
	Sun, 21 Dec 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FO/Xvx70";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5E5aAAs"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD7E2F9DBB
	for <linux-can@vger.kernel.org>; Sun, 21 Dec 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766322104; cv=none; b=eqgyS5RlWckhRUKohwOqnwGOLrDeYvlkttVIEzQxA0JHMVqWB2PNoDySEabCCOl9/dfMBZ3Ak7FY9JK2XkM3sEUlM1KxISNd4k6j+hH2+OcSVXaqFR61gadrV6BY3/1FjGmcBeMFiYa3H5PVsW5kegkRFYlqRp9SyNtnvU4insw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766322104; c=relaxed/simple;
	bh=r/l++9P9ZQFYezT7EWoWTYZqwqRX752Us4hOn2z8DIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3t8DG9jx8gFOc27xvNZrHOmS7WUH1wtAz7tmH6EOJhtbG7rMbgSIULlAbAo0ZeitQ2Q9RTAg7xtDZi9CFfO6J+95MJLTEa8uA7F2EANF8SBF4CCFJWOGogjdJB4UiOpBCRRKVLzK5vOjlDYjXAVavnDrNhZSxxJINkA+EveSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FO/Xvx70; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5E5aAAs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766322099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lGR8PtvLZUdl7Zy3cTdgViEKvGtjsOxM0M1Ktn+qFkc=;
	b=FO/Xvx70faX48yTseGCgY/alPWVHLBW68HhTp0SfKrsOQ8YdaVcrhmfFVXnsewcXVOtGWA
	fTax2MGeRu5rmsEVGWfq/+pdleNdC7/5097FL61P5eFnXBob3r5uRK5MEbeDuhZWJI0dss
	rUmHFR+rQsfVRafAOhDjOyx+POhno6g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-dMig3lJRPdaKH37ZYT73Ew-1; Sun, 21 Dec 2025 08:01:38 -0500
X-MC-Unique: dMig3lJRPdaKH37ZYT73Ew-1
X-Mimecast-MFC-AGG-ID: dMig3lJRPdaKH37ZYT73Ew_1766322097
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fdaba167so1662135f8f.3
        for <linux-can@vger.kernel.org>; Sun, 21 Dec 2025 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766322097; x=1766926897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGR8PtvLZUdl7Zy3cTdgViEKvGtjsOxM0M1Ktn+qFkc=;
        b=V5E5aAAsJ8cZhxQQLAwsT2/61EDRBKQunQKS3C0z+tgGTwCb4Vjp8RMff+C7m621rg
         RGwwhuuBn8baW5NIGWN9asxfYlVNyKQZnJhIQGtYMdQDWgMQGgXhHUO35DMLtSaJ97de
         7/Lu/viHFU+F83g0L3w280TptOhigeEcOjRTsGQtFzmj/ZmVcXncK8fGIozJ++c0fXvk
         lZsE/wV7c3kivMkv7BJCGRCsGy2vJMpoZLR1JRZne/1V5+fCRdqS9coBBwDfLj0F2cZo
         zBI7KqroFI1XHSWIj6mpUetl9rQ7+/W+RnbaGlISFeTevEwKlD6BeRSbNq8EK+NLFe05
         vSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766322097; x=1766926897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGR8PtvLZUdl7Zy3cTdgViEKvGtjsOxM0M1Ktn+qFkc=;
        b=dnmLCwQvELiXPoAnqTTmmswvDoSWPQjV7UzoUHF4OPMa7IOzQwf97nhFcyOXSqzY3d
         M9r5UuOJYPjvN32fPyK8ZU9cJ2egNqXgaEguYxt6+Mob4hcFCyp93aZbexj9cFgZzriH
         0DA+uuUZYn9pDlWwITUR8Y0Dbw2QTxpay/kORm3OeyPeRk0zUCtGFW2iAehvbO7ao3w2
         ra1PIMePCMxhDWG/rzDwRmgViynvts9TI0Zm/CZna3T+pptvsf0JN6dpWyoqGhqHQNDX
         0W4uKt8QGixoP/9ek0O8nU3jZmBA6kLgAKOXMf72Wlhq361KZBz57NTrLeX19rGWOR8Q
         mZBg==
X-Forwarded-Encrypted: i=1; AJvYcCVzn6ilV6OwlJnDc1FEl0E4XhQtmH3K0LqeAHdj9nH9ihT1QHk26Qcc5vSeXj2eM6eVDYpLB8bstbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmUX3jeFAnr5JdaMI4xmGL7Vh6fSUEI5O8w5uVB+9OGH+SLVC
	F70ROV4KezcnabDf0b4vbB8LZiZoemqsRepLRYJ0A5GGyKTFSvVKla38jMooRw7SV97WfSESscD
	+aYvMUtFg483wmJgdLklMr4T+are12XkHGAnsdUkh9Kk+tUPhFqlOYezlVV/Gsw==
X-Gm-Gg: AY/fxX6mB6ANt/lkJCdQl1K5parvJxkHau7cuD/z/xFuRsKBgCvRy0FUujwhaY2AVZT
	G0jJgTtdS38Rm3UsoWJPt9taBJYZxWfp4tQj1bvYFSO/XTmq/kij7rSz2JCPi8PLBloaN5t2c6I
	ekmzhzX/CyFiQm0TIH24RZQDmpxLYu2I8EQwao9y6AF5e1y9Ril1q2i22g03uTsl32LywfhWcZO
	ecT2AjQPYANKEFsnNMIAh5sg1odBdo1q2i6g+khsep7PY0c/4zpANsHmDXWPLCQVVz+eeLNIzOY
	J6pyy3e/2rYadIbnCDqDkM17K9VKJAdgCLkHDnC2UIC5gHS2h3BA4VBHYFByN3wWFKQiiggY5yE
	DE2jXHpzj3PRjDLlwWjKWFoCjlsAyg9cb5w==
X-Received: by 2002:a5d:5d09:0:b0:431:316:9212 with SMTP id ffacd0b85a97d-4324e4c0d41mr7897925f8f.6.1766322097133;
        Sun, 21 Dec 2025 05:01:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoP4c9iCRyFH6aDijVCnBbm8uxQua9fnzcLA7uhunToEhizPkn3OIbaZUr+g2smxgN0Xl4UA==
X-Received: by 2002:a5d:5d09:0:b0:431:316:9212 with SMTP id ffacd0b85a97d-4324e4c0d41mr7897894f8f.6.1766322096492;
        Sun, 21 Dec 2025 05:01:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2253csm16586880f8f.14.2025.12.21.05.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 05:01:35 -0800 (PST)
Date: Sun, 21 Dec 2025 08:01:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Francesco Valla <francesco@valla.it>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
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
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <20251221075954-mutt-send-email-mst@kernel.org>
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
> Locking may or may not be necessary here. I cannot tell in this moment.

you need a way to make sure add buf and get buf do not run
in parallel. virtio does not provide this protection itself.
up to the caller.

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


