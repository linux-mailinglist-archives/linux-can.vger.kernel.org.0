Return-Path: <linux-can+bounces-5461-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E7C635F3
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 10:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 524D9361063
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBB3271F0;
	Mon, 17 Nov 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI9bjO6D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="geY7MCV+"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312D3246E6
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372966; cv=none; b=gmt5qO7HwGs3oDOcfAPwc28sBSFZ1ts/z8dcBI+mLtxY0WmgT4JFWPpwMF5UpWGn4Uxne+HY6jYtyxKYXHibCbRtax5Q6pco2AiQ9UPop49k5HCQa/E50PxGKaCDlAJEZPpNmX+HHOmnaJZfdxhoRSXk3kEGvG8QQolBuHAxuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372966; c=relaxed/simple;
	bh=dBKncLAfLPD35FCtFg92ZOBStcGEGQKThYtANcwXxqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmfLfUanZs2QUCK0CW4KuWujxGt6SkFq3EXTeHSJqIGVGTAec9QPneZkG8pgrJ/bKwdy+ifBxScpAqroNGsaTXDHaWA0eG3XAcC01BR3AW5XjG3cnF2BUUiWIbwgqHmP4Lzqgonn6hb23i/jkj1dCn3J7G2J5CcfNIibmyODEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EI9bjO6D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=geY7MCV+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763372963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue/8Mu6C0fbuTuTFY+eYuDcpN83UaVJV3kS18weTXRM=;
	b=EI9bjO6Dtl6WCz7mdUuDQpByCaCs1rqLY+8uiZKmUctewnmTSn86q1eqBlFN0HRLbF3v1T
	nhGI6PC23wmWgiZBAabrYVewEjs9Smu5lPMc/MRrwxpY77ayfVjInqFv+m2/ytW4tu5zCY
	SonCHEfZjPSYvutHY4T+8La8u2nARTI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-tJqBVWMkM3GfruU3VaMQ2g-1; Mon, 17 Nov 2025 04:49:21 -0500
X-MC-Unique: tJqBVWMkM3GfruU3VaMQ2g-1
X-Mimecast-MFC-AGG-ID: tJqBVWMkM3GfruU3VaMQ2g_1763372961
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso4193865e9.1
        for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763372960; x=1763977760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue/8Mu6C0fbuTuTFY+eYuDcpN83UaVJV3kS18weTXRM=;
        b=geY7MCV+rSweSsElPvNju8iTuG6eSLfH0Vq0DXC/JFdiTvlgV80ydRIoSCzAqGtOLt
         AGkIw0USnGUmDRNSr79XJuGvnChNkvAZ0Hr5/ZUCcBNFNzNZqo5qG0PWR4zkfNQa4GVg
         QghuvFCGoNNz4ZWDH1jR9OXYWzBTcLNP5GgVrMgtWYblXjSSa7We+xSvyKSYsL4StXhh
         Hp1VAHsOdVP2NzjpNrlLXQd6AeJdaBgC26uB6lt9JQ1ZpBK06RqE8ziu/BpY+aeDTP79
         ZOT1DT0+ex6gz8K1GhWYTExFuyfvWf7L9QcuhzHtBvx5MfOEp8XlNczos1Dl1ue7JYF+
         gSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763372960; x=1763977760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue/8Mu6C0fbuTuTFY+eYuDcpN83UaVJV3kS18weTXRM=;
        b=stwGD9M7903MXt7GetFdKfzBRR+pKJDJedtVUHqNy9h39trvo0zk1uA6mhq6KRw1dL
         OQOUqvkhaLjkkyjvBdbsS6SVHYsa0dkBIico+tGA8XQjOuXzYQUK4+siMR1lfyHm6dTI
         Q1folMwv+HmrM1pidSw5SsJwmHbqUxWnOCCmeWtw8cxbl1jZK5FsHlYLw0uu73nHzaUN
         3QhZiHCLq12ZP5Z+fGyD9+2sUi1hB+HlUnFbDG653pzUnIzBzHzNJYYIP5Q/GIIkhJuw
         EHIDS0qHvHqUhlKuZpF+3IWWXqMd1E7wopn/kgI4GIlyYtakmUMLpc0zQFr3vutH0KlW
         bLkw==
X-Forwarded-Encrypted: i=1; AJvYcCVM0ExzOeshhwi/jBEA75O9mxGbFQmgE0eTFEvEJvXBLCMdZ+YLN0ITzzuX1g72P2Cdpvgp0Nw52Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsioIB5oSCn8g8z14IuG5IQLnwoXPgccPaH+gGes53WFNjsXQ
	KfqxnprsfVzjDpVunaHDpES/PIUODtoYHkPlfMfmJNpOK+AJJ3GHT5WlXt9f73ITRSt93968PTx
	InPDKt2JYoH5S4AZqhfb46EEGmHAIU7MNU9/SIRqXaKDqVvwc0dnJuTTLmqSF6A==
X-Gm-Gg: ASbGnctLblLd8XsyLcSECG1nYNfp9mGzAUGJvbVBow/aFY+CBperdhI8QMTqhQVb/Sv
	Sg4MQQoG/+JGtv/ZKYxh1ErgsTqXjFw9P8XOGioYn8Ab37OTS/5DwgO+RG0EIFzV1kIq4E+VLg3
	MYuNxqH8I3DM9Eko9yCcHKHgDZj97Zr3A5h57p2Lqpr1LfdSBevqbWgjxryIjUSdSSnoQSwLrIq
	+/4L1EAdad0mjs9ziuANJQgK9hm6SLMeXi3QvkRvZE0bKDn7B1jH/tywn0c0fab01zaQAKuErgA
	+u/ryPq0Ggmt5z0KR+Y+ZyAkVAKvjCzpR8k4GK3pedQ01m231U6TROmbriVxdh+n1yv5BPw3/+m
	BIVbeA/Zsce7P/QB4OKs=
X-Received: by 2002:a05:600c:1ca8:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-4778fd80818mr121160995e9.1.1763372960441;
        Mon, 17 Nov 2025 01:49:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER4dzoBaarF26xyWh4JNOPOaGIw3MrHVYkmRoNunV6sBZ7i2cCsa4sdybrELIeo7Kvgya9uA==
X-Received: by 2002:a05:600c:1ca8:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-4778fd80818mr121160705e9.1.1763372959915;
        Mon, 17 Nov 2025 01:49:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a04157c2sm71758645e9.1.2025.11.17.01.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:49:18 -0800 (PST)
Date: Mon, 17 Nov 2025 04:49:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
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
Message-ID: <20251117044156-mutt-send-email-mst@kernel.org>
References: <aQJRnX7OpFRY/1+H@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJRnX7OpFRY/1+H@fedora>

On Wed, Oct 29, 2025 at 06:40:45PM +0100, Matias Ezequiel Vara Larsen wrote:
> Add virtio CAN driver based on Virtio 1.4 specification (see
> https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4). The driver
> implements a complete CAN bus interface over Virtio transport,
> supporting both CAN Classic and CAN-FD Ids. In term of frames, it
> supports classic and CAN FD. RTR frames are only supported with classic
> CAN.
> 
> Usage:
> - "ip link set up can0" - start controller
> - "ip link set down can0" - stop controller
> - "candump can0" - receive frames
> - "cansend can0 123#DEADBEEF" - send frames
> 
> Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
> Signed-off-by: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>
> Co-developed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>
> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> ---
> V6:
> * Address nits (see
>   https://lore.kernel.org/all/aO0JjDGk2zLlzB1E@fedora/T/#mc7221192856d557da9c0da2b47e4343dfea0ca2f)
> * Check for error during register_virtio_can()
> * Remove virtio_device_ready()
> * Allocate virtio_can_rx rpkt[] at probe
> * Define virtio_can_control struct
> * Return VIRTIO_CAN_RESULT_NOT_OK after unlocking
> * Define sdu[] as a flex array for both tx and rx. For rx, use
>   VIRTIO_CAN_F_CAN_FD to figure out the max len for sdu
> * Fix statistics in virtio_can_read_tx_queue() and
>   how we indicate error to the user when getting
>   VIRTIO_CAN_RESULT_NOT_OK
> * Fix syntax of virtio_find_vqs()
> * Drop tx_list
> * Fix values of VIRTIO_CAN_F_LATE_TX_ACK and VIRTIO_CAN_F_RTR_FRAMES
> * Tested with vhost-device-can
>   (see
>   https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-can)
>   and qemu (see
>   https://github.com/virtualopensystems/qemu/tree/vhu-can-rfc) 
> 
> V5:
> * Re-base on top of linux-next (next-20240103)
> * Tested with https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3
> 
> RFC V4:
> * Apply reverse Christmas tree style
> * Add member *classic_dlc to RX and TX CAN frames
> * Fix race causing a NETDEV_TX_BUSY return
> * Fix TX queue going stuck on -ENOMEM
> * Update stats.tx_dropped on kzalloc() failure
> * Replace "(err != 0)" with "(unlikely(err))"
> * Use "ARRAY_SIZE(sgs)"
> * Refactor SGs in virtio_can_send_ctrl_msg()
> * Tested with https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3
> 
> RFC V3:
> * Incorporate patch "[PATCH] can: virtio-can: cleanups" from
>   https://lore.kernel.org/all/20230424-footwear-daily-9339bd0ec428-mkl@pengutronix.de/
> * Add missing can_free_echo_skb()
> * Replace home-brewed ID allocator with the standard one from kernel
> * Simplify flow control
> * Tested with https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3
> 
> RFC V2:
> * Remove the event indication queue and use the config space instead, to
>   indicate a bus off condition
> * Rework RX and TX messages having a length field and some more fields for CAN
>   EXT
> ---
>  MAINTAINERS                     |    7 +
>  drivers/net/can/Kconfig         |   12 +
>  drivers/net/can/Makefile        |    1 +
>  drivers/net/can/virtio_can.c    | 1022 +++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_can.h |   78 +++
>  5 files changed, 1120 insertions(+)
>  create mode 100644 drivers/net/can/virtio_can.c
>  create mode 100644 include/uapi/linux/virtio_can.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80cd3498c293..14a738b8ecb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27068,6 +27068,13 @@ F:	drivers/scsi/virtio_scsi.c
>  F:	include/uapi/linux/virtio_blk.h
>  F:	include/uapi/linux/virtio_scsi.h
>  
> +VIRTIO CAN DRIVER
> +M:	"Harald Mommer" <harald.mommer@oss.qualcomm.com>
> +L:	linux-can@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/can/virtio_can.c
> +F:	include/uapi/linux/virtio_can.h
> +

So how will maintainance look like for this?
Don't you want to co-maintain it, given you are submitting it?
The maintainer is supposed to interact with linux.


Probably a good idea to have this under
VIRTIO CORE AND NET DRIVERS

at least additionally, or alternatively add
L:	virtualization@lists.linux.dev



>  VIRTIO CONSOLE DRIVER
>  M:	Amit Shah <amit@kernel.org>
>  L:	virtualization@lists.linux.dev
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index d43d56694667..7b5806f11853 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -217,6 +217,18 @@ config CAN_XILINXCAN
>  	  Xilinx CAN driver. This driver supports both soft AXI CAN IP and
>  	  Zynq CANPS IP.
>  
> +config CAN_VIRTIO_CAN
> +	depends on VIRTIO
> +	tristate "Virtio CAN device support"
> +	default n
> +	help
> +	  Say Y here if you want to support for Virtio CAN.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called virtio-can.
> +
> +	  If unsure, say N.
> +
>  source "drivers/net/can/c_can/Kconfig"
>  source "drivers/net/can/cc770/Kconfig"
>  source "drivers/net/can/ctucanfd/Kconfig"
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index 56138d8ddfd2..2ddea733ed5d 100644


