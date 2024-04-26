Return-Path: <linux-can+bounces-493-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8141B8B37DC
	for <lists+linux-can@lfdr.de>; Fri, 26 Apr 2024 15:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6ED1F23078
	for <lists+linux-can@lfdr.de>; Fri, 26 Apr 2024 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335D91474DB;
	Fri, 26 Apr 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIIMDk5u"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBF13E88A
	for <linux-can@vger.kernel.org>; Fri, 26 Apr 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136534; cv=none; b=PAhE28UFZOtUxvskjm1TPl4hkPZs4XBbUZw1nbajcZLKo9BlT30QLSxuKkEKJwVLh4uRZAJouA7Oyk8xeYwEkL9MLcT7KLAdInjipE2I7ONcsA+TbJM6hFjO0vJSq0zsveuycWUmjXnuUlIOtGfmDJGc0cX/ap0k55a1SihuXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136534; c=relaxed/simple;
	bh=4tx9L/jsbzaLonjVZvgP/YsEuiSsqChffRpSgDVgga0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8ipwvWXUyWddJJTU/tPc5JVt7q+upUQ44NBzgCWeAtBwXgbVYpb0Aw8NBYllQHOVxAZG+5RFo1ljtYAkWMOoqjZ47g3I9RKCYj1dbpt7MS8AD5NfIPTZEDSKSB9DoY16FgUzVIz2qufUSO3P0+WyTP/AiYUXHmqaPvlTrI+wEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIIMDk5u; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57230faeb81so1394708a12.0
        for <linux-can@vger.kernel.org>; Fri, 26 Apr 2024 06:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714136530; x=1714741330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pabLm3qBrdibQD2ugwy0Rf8X7ueDzlshIa60bup3yyw=;
        b=DIIMDk5ux0WPBgGavkMzXguWTNNNi4CFxGTa3whM/A8YNAV907w+D99wh6x53H/eB6
         so2X+SMDG3cgvGjmLQCj6Vi93r583rQ55M+BSTic9vtMm/B7ce5vRw6dIKhgmEYayLgg
         kaqChwTJvtCpfojf0OolfaWsS2JC/DWx5zcZ89Iofec9oyR75MztSfTcMth3G6lTwC87
         od4RVAw4QRj7+jadMRRAOhZvp15rwTswHAkHeliUiNL9iG2jTh3m25ul79yGk/vWhd2z
         +Kwc7dJLpQk+R8dUvg5C6v1AU815io1OK6U8LekXQP2+pFvuERCf48d2oYo9qPw2NEBE
         BUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714136530; x=1714741330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pabLm3qBrdibQD2ugwy0Rf8X7ueDzlshIa60bup3yyw=;
        b=cmndUVtAAwYvi1MiSCv8ovFkLmzck1eCTW54N35aF7aXinGrlGCBrLFOgielJ0J8BB
         fCYXZbhvBQ6RtiQMSvkP2vkwjs76/1qWbbYC4R1dTo6RxQDI7SuJf803JP6rqZQCuI9Y
         ENNPFfYP2ZCiy3liWA0TZZE9yH2YP/nycOsavzlaaN1jT/FxrNn1we6bGHt1JVgMXROH
         9fMTTreKssKPgQGXvu0p2g+1PXQxhc54TCGOEwOsQp+9kZ2++mDcleayNbeZuWsCANwp
         /9J/w2rxJ2hepEeJrEYIDQpzQnKPoORUOPYn6mV6ptlxCZrY0Ei23mHJg4TxdxcazlhJ
         Nhig==
X-Gm-Message-State: AOJu0Yy4PN+LI+zWljoI2q7jE6CoEVN1EKj5fh2JuxaqE6zayF3T0BUn
	mwiv6qd8QhVA6zCi6oiPJC+ysjzbEHaKPnMxg1qWYT3l9oDBqZuk
X-Google-Smtp-Source: AGHT+IHLxWQp1NwwUGLZm21IWDT3j+ApgvuwD8VasqztNyCJCYhXm7rNiTGCDfjUgFrtZ88vAu/bwA==
X-Received: by 2002:a50:cc81:0:b0:568:a655:49c6 with SMTP id q1-20020a50cc81000000b00568a65549c6mr2149601edi.8.1714136529967;
        Fri, 26 Apr 2024 06:02:09 -0700 (PDT)
Received: from fedora (host-79-27-41-113.retail.telecomitalia.it. [79.27.41.113])
        by smtp.gmail.com with ESMTPSA id cx13-20020a05640222ad00b005725c9fd169sm404372edb.39.2024.04.26.06.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:02:09 -0700 (PDT)
Date: Fri, 26 Apr 2024 15:02:07 +0200
From: Francesco Valla <valla.francesco@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: isotp: remove ISO 15675-2 specification version
 where possible
Message-ID: <ZiulzzGIM9CXQMY-@fedora>
References: <20240420194746.4885-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420194746.4885-1-socketcan@hartkopp.net>

Hello,

just one small observation below. Other that that (FWIW):

Acked-by: Francesco Valla <valla.francesco@gmail.com>


On Sat, Apr 20, 2024 at 09:47:46PM +0200, Oliver Hartkopp wrote:
> With the new ISO 15765-2:2024 release the former documentation and comments
> have to be reworked. This patch removes the ISO specification version/date
> where possible.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/uapi/linux/can/isotp.h |  2 +-
>  net/can/Kconfig                | 11 +++++------
>  net/can/isotp.c                | 11 ++++++-----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
> index 6cde62371b6f..bd990917f7c4 100644
> --- a/include/uapi/linux/can/isotp.h
> +++ b/include/uapi/linux/can/isotp.h
> @@ -1,10 +1,10 @@
>  /* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
>  /*
>   * linux/can/isotp.h
>   *
> - * Definitions for isotp CAN sockets (ISO 15765-2:2016)
> + * Definitions for ISO 15765-2 CAN transport protocol sockets
>   *
>   * Copyright (c) 2020 Volkswagen Group Electronic Research
>   * All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index cb56be8e3862..af64a6f76458 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -54,20 +54,19 @@ config CAN_GW
>  	  by the netlink configuration interface known e.g. from iptables.
>  
>  source "net/can/j1939/Kconfig"
>  
>  config CAN_ISOTP
> -	tristate "ISO 15765-2:2016 CAN transport protocol"
> +	tristate "ISO 15765-2 CAN transport protocol"
>  	help
>  	  CAN Transport Protocols offer support for segmented Point-to-Point
>  	  communication between CAN nodes via two defined CAN Identifiers.
> +	  This protocol driver implements segmented data transfers for CAN CC
> +	  (aka Classical CAN, CAN 2.0B) and CAN FD frame types which were
> +	  introduced with ISO 15765-2:2016.

ISO 15765-2 also supports CAN2.0A networks, so I'd drop CAN 2.0B here.

>  	  As CAN frames can only transport a small amount of data bytes
> -	  (max. 8 bytes for 'classic' CAN and max. 64 bytes for CAN FD) this
> +	  (max. 8 bytes for CAN CC and max. 64 bytes for CAN FD) this
>  	  segmentation is needed to transport longer Protocol Data Units (PDU)
>  	  as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
>  	  traffic.
> -	  This protocol driver implements data transfers according to
> -	  ISO 15765-2:2016 for 'classic' CAN and CAN FD frame types.
> -	  If you want to perform automotive vehicle diagnostic services (UDS),
> -	  say 'y'.
>  
>  endif
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 25bac0fafc83..16046931542a 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -70,25 +70,26 @@
>  #include <linux/can/isotp.h>
>  #include <linux/slab.h>
>  #include <net/sock.h>
>  #include <net/net_namespace.h>
>  
> -MODULE_DESCRIPTION("PF_CAN isotp 15765-2:2016 protocol");
> +MODULE_DESCRIPTION("PF_CAN ISO 15765-2 transport protocol");
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
>  MODULE_ALIAS("can-proto-6");
>  
>  #define ISOTP_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp)
>  
>  #define SINGLE_MASK(id) (((id) & CAN_EFF_FLAG) ? \
>  			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
>  			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
>  
> -/* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
> - * take full 32 bit values (4 Gbyte). We would need some good concept to handle
> - * this between user space and kernel space. For now set the static buffer to
> - * something about 8 kbyte to be able to test this new functionality.
> +/* Since ISO 15765-2:2016 the CAN isotp protocol supports more than 4095
> + * byte per ISO PDU as the FF_DL can take full 32 bit values (4 Gbyte).
> + * We would need some good concept to handle this between user space and
> + * kernel space. For now set the static buffer to something about 8 kbyte
> + * to be able to test this new functionality.
>   */
>  #define DEFAULT_MAX_PDU_SIZE 8300
>  
>  /* maximum PDU size before ISO 15765-2:2016 extension was 4095 */
>  #define MAX_12BIT_PDU_SIZE 4095
> -- 
> 2.39.2
> 

