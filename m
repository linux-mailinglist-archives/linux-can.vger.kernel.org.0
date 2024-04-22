Return-Path: <linux-can+bounces-453-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2B8AC3E8
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 07:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AD31F21F4B
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 05:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5D18059;
	Mon, 22 Apr 2024 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiHBGSr+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D781B964
	for <linux-can@vger.kernel.org>; Mon, 22 Apr 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765042; cv=none; b=hyis7LaH+I2O/BhzytQbt8sX+cYuBjdlhqbRejQnaVCQl38Q986nWFOnP0nfx/bBgGQWKYJM0SkrUxW5aci4R0N0zZ1XyHKnceXac7CO8v1QxbQcBx9nz0vkkrjGGXUNP0C0GjGpotdg7lo2YLQCxgrNPldxZL1dBKIqUSZOjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765042; c=relaxed/simple;
	bh=85BbHvsuCYK7Ck+ERcQqw61e7bBjuLPidlASzc4zeog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Of7jt08qwLVzpV8Cf/LseH0V6Ay9RyHzfSpgmPyNsoVrL5cTzqocYuXAKuJnoeYzoio28q+M8ixhSU9cw5vbt2D9uxi5vbbpq4wxNxxoXNtYZUaDWaK44jFwgz0zQ7F8Ls/yKS5KA9xukoEJL34R+u+npnMQG53f2dMgNkVrRqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiHBGSr+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a2e5d86254so3427966a91.1
        for <linux-can@vger.kernel.org>; Sun, 21 Apr 2024 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713765040; x=1714369840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cWzfBS1MVum6cLnpBzkrrBYMfkXKfvOtZEdhxryLkOQ=;
        b=TiHBGSr+OHJGf0VG2Hho7GFml3e3uGBajbgqArldeX3hhVWtnnMEjHjSQI+7OduvsG
         lTKD0nI8W0Wa1ZDjC4zyR+wFpEdADjpqI0ZvzW359DhrXsrcZT2HvofjXf7O1LWapO4n
         56GoLOew2dDB7QbkDrps95TtqyMB1zubtqqNyPKv9IdEByOXX+HzJ0FLuWavLHPcg+FA
         gmweP5B+KemBPfU7NkBvOXWr4hh28dTMAHouW/WUse2DIqenMRvewCfu4YlE1JBNbT+x
         H9uzg43KWqu/jSJW+DBEL0iggr/5R4oNxYdT/sMPbCGX6kH3sUAz3yHzt2x/qxLEzsJG
         a5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713765040; x=1714369840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWzfBS1MVum6cLnpBzkrrBYMfkXKfvOtZEdhxryLkOQ=;
        b=YTHZYWMgUr6aEwvvgfElyXGeZvyOa4g3/NIV0FXjruM9cBTuY0e7zFds8ngo6Mq0nF
         3ujFTInNlwKKat/i5NCikqgGbnYiJITY274TxmCybPxpON/lLRcK/VyVNv+FWyTjRac3
         ueJbSdowMA6LDJmI+eN10uMTqQ3njLSZjLuPW8rGySmDX006qonBEfOrzYh7PL1Z30aT
         fAEQLPhoFzUx7rAx/i3xEkg8MPiFQfEc1tVDfU1EtssNpuD6QDmkX5Me1dnMX5DS0jQc
         tB+HPdTj6E1yD+e+lCaoy4QcclFoWUuZSuKR9MI1kbUwn4q2ZdR3oMndg3Vhibjl4ToF
         xSnA==
X-Gm-Message-State: AOJu0Yyb4bUgNaw3RRbHcC2rg/inWMpU/UY3qL3lvBPkd8SMFSoYCWaY
	TJV2EdGVRi5REzWf/iywwbyLFFQKXS3bEaC6+thk/SyyxrHCxCbG0DlVVaJgsn0NLnvuv/vYKyO
	QilKfA6MjMVd1g/QWIRK+vnEkktWzxFO7
X-Google-Smtp-Source: AGHT+IFz5lUcJSfTMUN+qOzcyw84/u9vMDTFvT8VohteiaGWuwYGax0DgKCNfltHAohuwI6SUGbCb4gWYCYYG5ulUCQ=
X-Received: by 2002:a17:90a:cf04:b0:2a7:329c:7976 with SMTP id
 h4-20020a17090acf0400b002a7329c7976mr12123047pju.8.1713765039809; Sun, 21 Apr
 2024 22:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420194746.4885-1-socketcan@hartkopp.net>
In-Reply-To: <20240420194746.4885-1-socketcan@hartkopp.net>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Mon, 22 Apr 2024 14:50:28 +0900
Message-ID: <CAMZ6Rq+3LJKcU5+nQmZ95AyLMqQe=y4_tCsBbuZ_j2cSuz9+3A@mail.gmail.com>
Subject: Re: [PATCH] can: isotp: remove ISO 15675-2 specification version
 where possible
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun. 21 Apr. 2024 at 04:48, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> With the new ISO 15765-2:2024 release the former documentation and comments
> have to be reworked. This patch removes the ISO specification version/date
> where possible.

The patch also renames "classical CAN" into "CAN CC", which is fine
but maybe add one sentence in the patch description for that.

Aside from that nitpick, one comment (see below). Meanwhile, I am
giving my acknowledgement in advance:

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thank you.

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
>           by the netlink configuration interface known e.g. from iptables.
>
>  source "net/can/j1939/Kconfig"
>
>  config CAN_ISOTP
> -       tristate "ISO 15765-2:2016 CAN transport protocol"
> +       tristate "ISO 15765-2 CAN transport protocol"
>         help
>           CAN Transport Protocols offer support for segmented Point-to-Point
>           communication between CAN nodes via two defined CAN Identifiers.
> +         This protocol driver implements segmented data transfers for CAN CC
> +         (aka Classical CAN, CAN 2.0B) and CAN FD frame types which were
> +         introduced with ISO 15765-2:2016.
>           As CAN frames can only transport a small amount of data bytes
> -         (max. 8 bytes for 'classic' CAN and max. 64 bytes for CAN FD) this
> +         (max. 8 bytes for CAN CC and max. 64 bytes for CAN FD) this
>           segmentation is needed to transport longer Protocol Data Units (PDU)
>           as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
>           traffic.
> -         This protocol driver implements data transfers according to
> -         ISO 15765-2:2016 for 'classic' CAN and CAN FD frame types.
> -         If you want to perform automotive vehicle diagnostic services (UDS),
> -         say 'y'.

Not sure why that last sentence was removed. This is out of scope from
this patch and I think this can be helpful for the audience not aware
that UDS relies on ISO-TP. I suggest keeping that one.

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
>                          (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
>                          (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
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
>

