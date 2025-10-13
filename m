Return-Path: <linux-can+bounces-5149-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B3BD2622
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DB074EF9BE
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD62FB628;
	Mon, 13 Oct 2025 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6oSAc2u"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1392FB614
	for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349177; cv=none; b=JhbHxAMEqGFoocQ27vu5F6vySvOQ9PfqmgiDGHXdNE28+Z680ZHIBdcnCgH/LiC/3axJuF7hHNyLBxwV46dT4yfyK+gbV4v9AZYkLhtKECpEBTXWfsOeyMV71VsfulGk1EUnADDzA5DBMFvQPjqbQz6hGA2d474ae4vtoIWeAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349177; c=relaxed/simple;
	bh=Cv2pxU9WsCUo3pBsuAkVnFh3X1Cxe7DJidXgAYF03Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pcu33O5eN6N3wbIuoqlbado4aV/vp6vrQ41ZLYTsr+QeTQ5IDLmCV2nqZfDGs9ieMtAWyp7iNJszTVXkzdW5FUnZDAo75VR9zcBrMN9Rb5pf3fj6OxGUbLOMQmQDjG0a2HEpoXXSdnk8ciOwvN2jyjZUXQPj+BKHK3IsR2N3QE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6oSAc2u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760349174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6mqEeRrvidObhzNRzchLNQqA+ReDntMNjcs0lPjGX4=;
	b=N6oSAc2uct0bzdVoCIZc39peopA0MOdQEAeZ72eyOzOs2b8ZwTOfJ4RowXhRKakX/V5niH
	ASWMcq0wnPXbUaZUJKe0Ohp8B7zKvnnFVoTbVNT9B71x+Jrkqc4FIIQFY2YLW/G+n9ps83
	hDrkoh0hl5CBm+FMvmNqVfhqJqQrEvo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-5v63ckD1MreHMDqXKdFFyA-1; Mon, 13 Oct 2025 05:52:53 -0400
X-MC-Unique: 5v63ckD1MreHMDqXKdFFyA-1
X-Mimecast-MFC-AGG-ID: 5v63ckD1MreHMDqXKdFFyA_1760349172
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso3369518f8f.2
        for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 02:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349172; x=1760953972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6mqEeRrvidObhzNRzchLNQqA+ReDntMNjcs0lPjGX4=;
        b=faSN5YvPU9YCEFit7mxtJ95ARneOU/5ygEFQjo4NQJVSQTv1RTZ5Qm+8iF06zy+yIA
         c7w2m+2lN3Vzja3beoeWl/09SdNf722CAv2RJ/3WMSeRO5VExMqsJCkWHRUiy/f+FiND
         WoI6K2NTa5BGRIOygo9ZBwGdt8oLoTNjMy/+USlclksRLXpSHiyzcifachElJ+wckcSC
         z7K6IIPXlcgi60Xl559YrxuHfAZ34yxX95LWcr4ukUC0JpS/POrJdLx5ghsK3ongLbkt
         E2zLvS/vw63XpTVKPr7uxxfPSDzgGjpNTmigB1OaP9buoEYBUmf9Gl2l8ryjk/D2vm+i
         9PmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBsYcPO0un0tIaazCsQf1QObDBakXciCMFcz9eLcRIHQZmc0DGTSEgfi8rYZVJ3Jgc6vpr1G2157I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVj4h6Bu6oSpmTjDB39B4ULPkmvWkSU0pkIdwnDU1ZsvZkA6jU
	UEk+Im7pHPuquHaL/qnYYgAKKbz9mLE+PGYEngLFgivoN/uX94Pbb7fhvPozCPs+sw1vfH3Md8o
	ERhlyn2TniMAyRkCqdpOQd0mNe8cjRvrmAkWDCtn0mTFrOe0r9jjhDEk+UUC9U8WBd1oH7r61
X-Gm-Gg: ASbGncscvaAjLsCY/0XSvv+83n/EpI79jnp3QISeHhqkQhZ2FTrZeLbbUQtQ1uWfQJa
	Bq2z0ytLgMi98fWjV8NoJspTv7GCcY/fghpA7ig+9dxh7a3uFoNaKhmayJ2ipMZkhNLAKqwutRZ
	3Odz61CpRaoy7whRnpTwZmiCc4ItjitH6g1CXKptgALMmewCUmNmIj9d4kUgGUzHb3s9ttaDR77
	JjVQdX8hHIbVJDH3a/7mq3g5ahjcOJGt637mou+EeG9g+nFOciw/GvPUSMoZ4bgDuD4jH+LbFgY
	OsnswMXAbuKY2Lk1+YU4WFQAmU6soKlByQ==
X-Received: by 2002:a05:6000:41c9:b0:426:d54e:7f78 with SMTP id ffacd0b85a97d-426d54e802amr4973495f8f.18.1760349171971;
        Mon, 13 Oct 2025 02:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFToPVmudWTFsq6bFqEIEPs/FQujXTZ0U+mV3FlG97R8DNDTM+O9fu/M5ZF2UtsJ7uQAo9BZQ==
X-Received: by 2002:a05:6000:41c9:b0:426:d54e:7f78 with SMTP id ffacd0b85a97d-426d54e802amr4973477f8f.18.1760349171548;
        Mon, 13 Oct 2025 02:52:51 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf790sm16929272f8f.28.2025.10.13.02.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:52:51 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:52:49 +0200
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
Message-ID: <aOzL8f4C27z361P2@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
 <aOkqUWxiRDlm0Jzi@fedora>
 <2318164.vFx2qVVIhK@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2318164.vFx2qVVIhK@fedora.fritz.box>

On Fri, Oct 10, 2025 at 11:20:22PM +0200, Francesco Valla wrote:
> On Friday, 10 October 2025 at 17:46:25 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > Hello Mikhail, Harald,
> > > 
> > > hoping there will be a v6 of this patch soon, a few comments:
> > > 
> > 
> > I am working on the v6 by addressing the comments in this thread.
> > 
> > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > 
> > > [...]
> > > 
> > > > +
> > > > +/* virtio_can private data structure */
> > > > +struct virtio_can_priv {
> > > > +	struct can_priv can;	/* must be the first member */
> > > > +	/* NAPI for RX messages */
> > > > +	struct napi_struct napi;
> > > > +	/* NAPI for TX messages */
> > > > +	struct napi_struct napi_tx;
> > > > +	/* The network device we're associated with */
> > > > +	struct net_device *dev;
> > > > +	/* The virtio device we're associated with */
> > > > +	struct virtio_device *vdev;
> > > > +	/* The virtqueues */
> > > > +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> > > > +	/* I/O callback function pointers for the virtqueues */
> > > > +	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
> > > > +	/* Lock for TX operations */
> > > > +	spinlock_t tx_lock;
> > > > +	/* Control queue lock. Defensive programming, may be not needed */
> > > > +	struct mutex ctrl_lock;
> > > > +	/* Wait for control queue processing without polling */
> > > > +	struct completion ctrl_done;
> > > > +	/* List of virtio CAN TX message */
> > > > +	struct list_head tx_list;
> > > > +	/* Array of receive queue messages */
> > > > +	struct virtio_can_rx rpkt[128];
> > > 
> > > This array should probably be allocated dynamically at probe - maybe
> > > using a module parameter instead of a hardcoded value as length? 
> > > 
> > 
> > If I allocate this array in probe(), I would not know sdu[] in advance
> > if I defined it as a flexible array. That made me wonder: can sdu[] be
> > defined as flexible array for rx? 
> > 
> > Thanks.
> > 
> 
> One thing that can be done is to define struct virtio_can_rx as:
> 
> struct virtio_can_rx {
> #define VIRTIO_CAN_RX                   0x0101
> 	__le16 msg_type;
> 	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> 	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> 	__u8 padding;
> 	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> 	__le32 flags;
> 	__le32 can_id;
> 	__u8 sdu[] __counted_by(length);
> };
> 
> and then allocate the rpkt[] array using the maximum length for SDU:
> 
> priv->rpkt = kcalloc(num_rx_buffers,
> 		sizeof(struct virtio_can_rx) + VIRTIO_CAN_MAX_DLEN,
> 		GFP_KERNEL);
> 
> In this way, the size of each member of rpkt[] is known and is thus
> suitable for virtio_can_populate_vqs().
> 
> 

Thanks for your answer. What is the value of VIRTIO_CAN_MAX_DLEN? I
can't find it nor in the code or in the spec. I guess is 64 bytes? Also,
IIUC, using __counted_by() would not end up saving space but adding an
extra check for the compiler. Am I right? In that case, can't I just use
a fixed array of VIRTIO_CAN_MAX_DLEN bytes?

Thanks, Matias.


