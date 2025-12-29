Return-Path: <linux-can+bounces-5960-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EADFCE73F1
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10B73300BEDF
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2550422B8BD;
	Mon, 29 Dec 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUV9ZpGV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJvioHfR"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA761E8826
	for <linux-can@vger.kernel.org>; Mon, 29 Dec 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023250; cv=none; b=fLWQd6wWVA09vTTDAjbIqajBdmQZXj6tzamrNbVoHcVVndzPp6Bp4EV9MAzwyILb+IlkQsi42coDK+pK5hdUz7MK1O5cLqu6sv3Yi0+DdlK7Q5A78eMNMRn97qtmZoJ3FrDfMjB6vNIlkLVMeFwq2/7K/SRl82uvCje1D/yKrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023250; c=relaxed/simple;
	bh=mhCgMyPpA6PN3yVOHuOdBSAHQLvFlmqczKLfLDwflf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7DHQT9ILtSQdebtohVLxGqlso11DH45KyeEmkn97yj6A1SlTiHN1cEGu6Q18rcPWlYaSr826XtDzBuglasCe+vkYmLP4iZzlHd1l21PkN7x/m1RcP5EvH4QO1VWiYh3A8Lkqqt6P27QJ+m4ghWm3qe2Id4K6LMqkZpQVTMuwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUV9ZpGV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJvioHfR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767023247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cnHluyd0CLs9rtZivbBUXRafIxh4RF5VK55fRt2P2g=;
	b=LUV9ZpGVEPkmHORXnFSBR0rDgV3KeTzXBHmPgs9U4dN9K28Mn4jInrQOikPXTPuM5wKx1Q
	OkHQRVpKuwp5uixzEsHWbWG2kwj9GWJbvNy0VhET5/UQhxUHwQk+b8wA/jBHE2SaxTeXju
	ZvGVIzzA+jOkMkYUGPgT0kdnCqWp+bw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-T6I5hgLeO0iSelkNVFJJFA-1; Mon, 29 Dec 2025 10:47:25 -0500
X-MC-Unique: T6I5hgLeO0iSelkNVFJJFA-1
X-Mimecast-MFC-AGG-ID: T6I5hgLeO0iSelkNVFJJFA_1767023244
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325cc15176so4197166f8f.1
        for <linux-can@vger.kernel.org>; Mon, 29 Dec 2025 07:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767023244; x=1767628044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cnHluyd0CLs9rtZivbBUXRafIxh4RF5VK55fRt2P2g=;
        b=OJvioHfRni4nyXeZTW2hCBfECySD5ma1DilwosZVusXlOKZzStREvLJ9c5sGaRFs9r
         TL1Zgdggi/6vxW9uHhLrE+O35/YvRIj2QbPN66HQzfXrJWeuSjLsnFElEqzN6eO5uPRk
         HuWBZtULhYPNz5LBeSRHRz1jKZZeoBF3MdNHz0+iqzw9uCKI84Zq3DGCmlAsBjkE66NG
         4YihxacLBZ/7v7vTS4OT8ZZQp94OnQLQ0c8zaIS+Cw0GCWqdgS2Tt0HUV4Bk2ELB0Tzp
         mbdIF+tAFivo2H/cXrgUqprNYXK8+M97+9JZWuI4nd8magX0lhbAXyV9tocnpCESA0nb
         WvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767023244; x=1767628044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cnHluyd0CLs9rtZivbBUXRafIxh4RF5VK55fRt2P2g=;
        b=fyEKbCVAx7nm2NVDqh1xRHb9MFrFkAQ5lyhhjqowBEcI4D1uTH4KRUwEWKfp6SIAfq
         lC4VnqXalvmmHNq6VxrHpzdQxyrA2ycf5flt4my5LlrnzOmM7ckEUmwCpm5mTyMb34CZ
         3XKMrROSFr5b/MKNJ86Ng3RvDzTASAkZ/XmjtwnfaHewY5WUZn+VCx5BGDdvCLGdvajQ
         uyqPUCB7s4mk3fhCNKwfFebUo7lcbQzZLf3aY3HUUS1Nl8fd+TxP76p2AqNh0vNE9MxP
         QDkkpl8Vhf6wt1udsH5zjPTzkbsSSm9vzYUpXXCV7ObsJ1idGVYSTd+3wZwhAL/KaNvW
         Mt0w==
X-Forwarded-Encrypted: i=1; AJvYcCXlhivXtFEQEQf6wx9/G45KIPnOtbTwQXlB+yxEl8PmnynaBXJP0YgJogIohaLfvCgWPC3KVBC2zE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyB60wO18kHmI2qbnk1lZ/xGwiSeSzpsvkMsWCP+ROw/JoDqG
	yUj7+ULNM5DwKfgNgrMvFRv1lreB0dTAZGFpcCn0Nx0kbCJzBsYEotdYOnNa9/zfCo52TDwtRtS
	F8FZ5RJF9EIzq73o8AktCldAzLRX/ezKvoGb1KF5K4/8OHeDLuB48iblokLBt2w==
X-Gm-Gg: AY/fxX4O0U7dP5Z18POV0tyB335AtcMiPdWmBxII/IWn+hsdKSyI1uKBuh23FVI735I
	KJl7jfSP46sGzM5cAHQZ+F4K4U2y5kblq6lsuV0pOHCsFoos1mV83BL62zi4uG4vc+EUmAUvHb7
	KTv4orleKHlVnqvb3f5LrJ9rIo0+bNmPdNBYUZMsjhq+eui1MsjHl9Z7yT4hKYE/ejjjgf7idiy
	9wRU4jIUVB9c02rO0QRCguVHS/o2M+kjOuinTJfROZuKUT/AIIAFQQzWoJ87RZzK0OOD9Ocjnzx
	xfg4LXEyjw3KqzUZoXgoB8/vBYyo9upK/YAMWwFBIMWXxd5K4qiGr53oONccgbkRrfd3JcPjG1A
	=
X-Received: by 2002:a05:6000:1861:b0:430:f182:788f with SMTP id ffacd0b85a97d-4324e4cc554mr39523658f8f.21.1767023244048;
        Mon, 29 Dec 2025 07:47:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9KgR/b0s0HVFW/sbw2hCKfSRSBzsJZhjFf3671GVOJvGrUkexpDNZQnv9PMFYyD2Weeeb2g==
X-Received: by 2002:a05:6000:1861:b0:430:f182:788f with SMTP id ffacd0b85a97d-4324e4cc554mr39523625f8f.21.1767023243627;
        Mon, 29 Dec 2025 07:47:23 -0800 (PST)
Received: from fedora ([37.169.8.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aee5sm64128709f8f.4.2025.12.29.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 07:47:22 -0800 (PST)
Date: Mon, 29 Dec 2025 16:47:11 +0100
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
Message-ID: <aVKifw2noSECGCGS@fedora>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aU71oJScQ8aC0npw@fedora>
 <aU8Krjsv0_aC3E7A@bywater>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aU8Krjsv0_aC3E7A@bywater>

On Fri, Dec 26, 2025 at 11:22:38PM +0100, Francesco Valla wrote:
> On Fri, Dec 26, 2025 at 09:52:48PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > > +{
> > > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > > +	struct net_device *dev = can_priv->dev;
> > > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > > +	struct net_device_stats *stats;
> > > > > > +	unsigned long flags;
> > > > > > +	unsigned int len;
> > > > > > +	u8 result;
> > > > > > +
> > > > > > +	stats = &dev->stats;
> > > > > > +
> > > > > > +	/* Protect list and virtio queue operations */
> > > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > 
> > > > > The section below seems a pretty big one to protect behind a spin lock. 
> > > > > 
> > > > 
> > > > How can I split it? 
> > > > 
> > > 
> > > Question here is: what needs to be protected? As far as I can tell, the
> > > only entity needing some kind of locking here is the queue, while both
> > > ida_* and tx_inflight operations are already covered (the former by
> > > design [1], the second because it's implemented using an atomic.
> > > 
> > > If I'm not wrong (but I might be, so please double check) this can be
> > > limited to:
> > > 
> > > 	/* Protect queue operations */
> > > 	scoped_guard(spinlock_irqsave, &priv->tx_lock)
> > > 		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
> > > 
> > > 
> > > Maybe the whole locking pattern is a leftover from a previous version, 
> > > where a list of TX messages was kept?
> > > 
> > 
> > I followed this approach for the three queues. I wonder why the rx queue
> > and the ctrl queue use a mutex instead of spinlock? I added a mutex for
> > the operations to the rx queue.
> 
> If I interpreted correctly (but maybe Harald can shine some light on this):
> 

Thanks for the explanation.

> - the virtio_can_send_ctrl_msg() uses a mutex because it could be
>   executed in parallel by different actors (read: userspace processes
>   invoking up and down operations); moreover, is the whole control
>   operation that needs to be protected and not only the access to the
>   virtqueue_ functions, so a mutex should make sense;


In the code, a comment says that this lock may not be required. The lock
is used in virtio_can_send_ctrl_msg(), which is called only from
virtio_can_start() and virtio_can_stop(). But, the sending of control
msgs is sync,i.e., the driver first sends and then waits for a response
thus blocking the access to the control queue. This semantics requires a
mutex. I do not know if access to control queue may be implemented
differently thus preventing to keep the mutex during the whole access. 


> - the rx queue shouldn't actually need any locking, since it is accessed
>   only by the poll function and the network framework should guarantee
>   that no multiple parallel poll operations are called on a napi;
> - the tx queue needs instead to be protected, since it could
>   concurrently be accessed by both the start_xmit callback and the poll
>   function; a spinlock there makes more sense, as accesses should be
>   very short.
> 
> > 
> > Matias
> > 
> > 
> 
> Thank you
> 
> Regards,
> Francesco
> 


