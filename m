Return-Path: <linux-can+bounces-165-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E7983F4F0
	for <lists+linux-can@lfdr.de>; Sun, 28 Jan 2024 11:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE061C20C36
	for <lists+linux-can@lfdr.de>; Sun, 28 Jan 2024 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C421EB20;
	Sun, 28 Jan 2024 10:13:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A741EB22
	for <linux-can@vger.kernel.org>; Sun, 28 Jan 2024 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706436839; cv=none; b=Cmh17HX+to/ti9wvaJJA1kWRkLSjf2W2P844Ssyr2KoBrp0COs6VUW4JWqOsnREeSjZB0BbaKB76UOOUuF+ARwJTacNZPh9QZD/Gdd0rXErWkgmWRj0w+rj5w1Ijm3SNBg6OAZKexE6phktg2OUHw5cbqqtRtEUkjYsB+aAlhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706436839; c=relaxed/simple;
	bh=OxHD6xxzpU6wFjbf1yKp6xxJuqTddlv3wsm4Dxg2bx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcglMCfKT4wSv5atHxMLg8v0FC5IFDbNfiTUi/fFYgw93g2h9P0DnBOW9rShPzJYxNBWG8Dy1k+7VF4EbTbvaUQy/02ZEm5iAJvjKuo9CJ4RFZ6hcTSuuBUDN6uB137ZT/C6yE6DY+0gIMGLMlyh3U0T8VAw9OatBpy9Ab265l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff9adbf216so16556637b3.1
        for <linux-can@vger.kernel.org>; Sun, 28 Jan 2024 02:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706436836; x=1707041636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFzdT2LsqapKirJdZz5f+AHma4ej0rMJTSSdsckjd5Q=;
        b=CIIvsk/2WTjFs6yB6eZ7m8Ahp4yS1hhRtqDXj71gdsM91rQnWe9Zb+W+tPMsKR2wl9
         oAzTr/bBMdHE5Ux+6S/4lZQFzyBfEDzFvWNpveiCMEf9ZUbusJCuewW739lFDZxs5QTD
         Ggm+BLWwWaOjuyIjIxfaVw3W4WpRZgNR3fKPYmwWShcXfHmBxtCeHSGcfSwW+yudiwTl
         M+GsdprQD5Fz3zUw/dn7oJLz4Gjhrc+KiUWICniTVQ6KaOfeYgCGjO3mS4RS9OKxK3bl
         a/cOFo/oi7KnKCWU/aehl6SZ4a2aZANcT6nKjc2MaWrXOjKgiJZw/F4CJ65PclOkQoD0
         HHNA==
X-Gm-Message-State: AOJu0Yz/6ar7hWAjgNp8+SK0ioucZGij47yWdP/nTP9KUm/1QWbrlQMA
	S9Qzd2zssa8OXzFB2Kuan2fdquznERZDrs8dMUphgSk3JoXPaYuIKyGaZidi2KwRsRT8OlyuKN1
	B+a1Uuknin8BjCU6OMehWf1idWJjU4a74QC8=
X-Google-Smtp-Source: AGHT+IECT7cRu7NAalMPKDU42896VsUNDO20gApqgiUN3IxLCg1mjYN4lNHnjjJuFIMaKwL1ffixPt99QyoB3A/Y92E=
X-Received: by 2002:a81:6c87:0:b0:5ff:f210:ae71 with SMTP id
 h129-20020a816c87000000b005fff210ae71mr3931084ywc.55.1706436836033; Sun, 28
 Jan 2024 02:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108170644.1887-1-socketcan@hartkopp.net>
In-Reply-To: <20240108170644.1887-1-socketcan@hartkopp.net>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 28 Jan 2024 19:13:44 +0900
Message-ID: <CAMZ6RqK_O1gf+48Gv1fe1xnMb105rq3Pug9q9ZeheDbeNCeY_Q@mail.gmail.com>
Subject: Re: [PATCH v4] canxl: add virtual CAN network identifier support
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

Hi Oliver,

Sorry for the delay, last weeks were busier than average.

On Tue. 9 Jan 2024 at 02:10, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> CAN XL data frames contain an 8-bit virtual CAN network identifier (VCID).
> A VCID value of zero represents an 'untagged' CAN XL frame.
>
> To receive and send these optional VCIDs via CAN_RAW sockets a new socket
> option CAN_RAW_XL_VCID_OPTS is introduced to define/access VCID content:
>
> - tx: set the outgoing VCID value by the kernel (one fixed 8-bit value)
> - tx: pass through VCID values from the user space (e.g. for traffic replay)
> - rx: apply VCID receive filter (value/mask) to be passed to the user space
>
> With the 'tx pass through' option CAN_RAW_XL_VCID_TX_PASS all valid VCID
> values can be sent, e.g. to replay full qualified CAN XL traffic.
>
> The VCID value provided for the CAN_RAW_XL_VCID_TX_SET option will
> override the VCID value in the struct canxl_frame.vcid element defined
> for CAN_RAW_XL_VCID_TX_PASS when both flags are set.
>
> With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are
> passed to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set.
> Without this flag only untagged CAN XL frames (VCID = 0x00) are delivered
> to the user space (default).
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

I am not yet aware of all the details of CAN XL and its VCID, but to
the extent of my knowledge, the patch looks good.

I left two nitpicks. Notwithstanding: you can add my review tag to v5.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

> ---
>  include/uapi/linux/can.h     | 41 ++++++++++++++--------
>  include/uapi/linux/can/raw.h | 14 ++++++++
>  net/can/af_can.c             |  2 ++
>  net/can/raw.c                | 66 ++++++++++++++++++++++++++++++++++--
>  4 files changed, 106 insertions(+), 17 deletions(-)
>
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 939db2388208..8dcd8a9b5676 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -44,10 +44,11 @@
>   */
>
>  #ifndef _UAPI_CAN_H
>  #define _UAPI_CAN_H
>
> +#include <asm/byteorder.h>
>  #include <linux/types.h>
>  #include <linux/socket.h>
>  #include <linux/stddef.h> /* for offsetof */
>
>  /* controller area network (CAN) kernel definitions */
> @@ -193,26 +194,38 @@ struct canfd_frame {
>  #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
>  #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
>
>  /**
>   * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
> - * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> - * @flags: additional flags for CAN XL
> - * @sdt:   SDU (service data unit) type
> - * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
> - * @af:    acceptance field
> - * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
> - *
> - * @prio shares the same position as @can_id from struct can[fd]_frame.
> + * @prio:   11 bit arbitration priority (unused 5 bits must be set to zero)
> + *          Shares the lower 16 bits of @can_id from struct can[fd]_frame
> + * @vcid:   CAN XL virtual CAN network identifier
> + * @__res0: reserved / padding must be set to zero to maintain the CAN filter
> + *          functionality as is holds the @can_id flags CAN_xxx_FLAG
                                ^^
as it holds

> + * @flags:  additional flags for CAN XL
> + * @sdt:    SDU (service data unit) type
> + * @len:    frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
> + * @af:     acceptance field
> + * @data:   CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
>   */
>  struct canxl_frame {
> -       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> -       __u8    flags; /* additional flags for CAN XL */
> -       __u8    sdt;   /* SDU (service data unit) type */
> -       __u16   len;   /* frame payload length in byte */
> -       __u32   af;    /* acceptance field */
> -       __u8    data[CANXL_MAX_DLEN];
> +#if defined(__LITTLE_ENDIAN)
> +       __u16 prio;   /* 11 bit priority for arbitration */
> +       __u8  vcid;   /* virtual CAN network identifier */
> +       __u8  __res0; /* reserved / padding must be set to zero */
> +#elif defined(__BIG_ENDIAN)
> +       __u8  __res0; /* reserved / padding must be set to zero */
> +       __u8  vcid;   /* virtual CAN network identifier */
> +       __u16 prio;   /* 11 bit priority for arbitration */
> +#else
> +#error "Unknown endianness"
> +#endif
> +       __u8  flags;  /* additional flags for CAN XL */
> +       __u8  sdt;    /* SDU (service data unit) type */
> +       __u16 len;    /* frame payload length in byte */
> +       __u32 af;     /* acceptance field */
> +       __u8  data[CANXL_MAX_DLEN];
>  };
>
>  #define CAN_MTU                (sizeof(struct can_frame))
>  #define CANFD_MTU      (sizeof(struct canfd_frame))
>  #define CANXL_MTU      (sizeof(struct canxl_frame))
> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
> index 31622c9b7988..88e4e8176b89 100644
> --- a/include/uapi/linux/can/raw.h
> +++ b/include/uapi/linux/can/raw.h
> @@ -63,8 +63,22 @@ enum {
>         CAN_RAW_LOOPBACK,       /* local loopback (default:on)       */
>         CAN_RAW_RECV_OWN_MSGS,  /* receive my own msgs (default:off) */
>         CAN_RAW_FD_FRAMES,      /* allow CAN FD frames (default:off) */
>         CAN_RAW_JOIN_FILTERS,   /* all filters must match to trigger */
>         CAN_RAW_XL_FRAMES,      /* allow CAN XL frames (default:off) */
> +       CAN_RAW_XL_VCID_OPTS,   /* CAN XL VCID configuration options */
>  };
>
> +/* configuration for CAN XL virtual CAN identifier (VCID) handling */
> +struct can_raw_vcid_options {
> +       __u8 flags;             /* flags for vcid (filter) behaviour */
> +       __u8 tx_vcid;           /* VCID value set into canxl_frame.vcid */
> +       __u8 rx_vcid;           /* VCID value for VCID filter */
> +       __u8 rx_vcid_mask;      /* VCID mask for VCID filter */
> +};
> +
> +/* can_raw_vcid_options.flags for CAN XL virtual CAN identifier handling */
> +#define CAN_RAW_XL_VCID_TX_SET         0x01
> +#define CAN_RAW_XL_VCID_TX_PASS                0x02
> +#define CAN_RAW_XL_VCID_RX_FILTER      0x04
> +
>  #endif /* !_UAPI_CAN_RAW_H */
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 7343fd487dbe..707576eeeb58 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -863,10 +863,12 @@ static __init int can_init(void)
>         int err;
>
>         /* check for correct padding to be able to use the structs similarly */
>         BUILD_BUG_ON(offsetof(struct can_frame, len) !=
>                      offsetof(struct canfd_frame, len) ||
> +                    offsetof(struct can_frame, len) !=
> +                    offsetof(struct canxl_frame, flags) ||
>                      offsetof(struct can_frame, data) !=
>                      offsetof(struct canfd_frame, data));
>
>         pr_info("can: controller area network core\n");
>
> diff --git a/net/can/raw.c b/net/can/raw.c
> index e6b822624ba2..3083df64723c 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -89,10 +89,11 @@ struct raw_sock {
>         struct list_head notifier;
>         int loopback;
>         int recv_own_msgs;
>         int fd_frames;
>         int xl_frames;
> +       struct can_raw_vcid_options raw_vcid_opts;
>         int join_filters;
>         int count;                 /* number of active filters */
>         struct can_filter dfilter; /* default/single filter */
>         struct can_filter *filter; /* pointer to filter(s) */
>         can_err_mask_t err_mask;
> @@ -132,14 +133,34 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>         /* check the received tx sock reference */
>         if (!ro->recv_own_msgs && oskb->sk == sk)
>                 return;
>
>         /* make sure to not pass oversized frames to the socket */
> -       if ((!ro->fd_frames && can_is_canfd_skb(oskb)) ||
> -           (!ro->xl_frames && can_is_canxl_skb(oskb)))
> +       if (!ro->fd_frames && can_is_canfd_skb(oskb))
>                 return;
>
> +       if (can_is_canxl_skb(oskb)) {
> +               struct canxl_frame *cxl = (struct canxl_frame *)oskb->data;
> +               struct can_raw_vcid_options *ropts = &ro->raw_vcid_opts;
> +
> +               /* make sure to not pass oversized frames to the socket */
> +               if (!ro->xl_frames)
> +                       return;
> +
> +               /* filter CAN XL VCID content */
> +               if (ropts->flags & CAN_RAW_XL_VCID_RX_FILTER) {
> +                       /* apply VCID filter if user enabled the filter */
> +                       if ((cxl->vcid & ropts->rx_vcid_mask) !=
> +                           (ropts->rx_vcid & ropts->rx_vcid_mask))
> +                               return;
> +               } else {
> +                       /* no filter => do not forward VCID tagged frames */
> +                       if (cxl->vcid)
> +                               return;
> +               }
> +       }
> +
>         /* eliminate multiple filter matches for the same skb */
>         if (this_cpu_ptr(ro->uniq)->skb == oskb &&
>             this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
>                 if (!ro->join_filters)
>                         return;
> @@ -696,10 +717,19 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>                 /* Enabling CAN XL includes CAN FD */
>                 if (ro->xl_frames)
>                         ro->fd_frames = ro->xl_frames;
>                 break;
>
> +       case CAN_RAW_XL_VCID_OPTS:
> +               if (optlen != sizeof(ro->raw_vcid_opts))
> +                       return -EINVAL;
> +
> +               if (copy_from_sockptr(&ro->raw_vcid_opts, optval, optlen))
> +                       return -EFAULT;
> +
> +               break;
> +
>         case CAN_RAW_JOIN_FILTERS:
>                 if (optlen != sizeof(ro->join_filters))
>                         return -EINVAL;
>
>                 if (copy_from_sockptr(&ro->join_filters, optval, optlen))
> @@ -784,10 +814,25 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>                 if (len > sizeof(int))
>                         len = sizeof(int);
>                 val = &ro->xl_frames;
>                 break;
>
> +       case CAN_RAW_XL_VCID_OPTS:
> +               /* user space buffer to small for VCID opts? */
> +               if (len < sizeof(ro->raw_vcid_opts)) {
> +                       /* return -ERANGE and needed space in optlen */
> +                       err = -ERANGE;
> +                       if (put_user(sizeof(ro->raw_vcid_opts), optlen))
> +                               err = -EFAULT;
> +               } else {
> +                       if (len > sizeof(ro->raw_vcid_opts))
> +                               len = sizeof(ro->raw_vcid_opts);
> +                       if (copy_to_user(optval, &ro->raw_vcid_opts, len))
> +                               err = -EFAULT;
> +               }
> +               break;
> +
>         case CAN_RAW_JOIN_FILTERS:
>                 if (len > sizeof(int))
>                         len = sizeof(int);
>                 val = &ro->join_filters;
>                 break;
> @@ -814,12 +859,27 @@ static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
>             (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>                 return false;
>
>         /* CAN XL -> needs to be enabled and a CAN XL device */
>         if (ro->xl_frames && can_is_canxl_skb(skb) &&
> -           can_is_canxl_dev_mtu(mtu))
> +           can_is_canxl_dev_mtu(mtu)) {
> +               struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
> +               struct can_raw_vcid_options *ropts = &ro->raw_vcid_opts;
> +
> +               /* sanitize non CAN XL bits */
> +               cxl->__res0 = 0;
> +
> +               /* clear VCID in CAN XL frame if pass through is disabled */
> +               if (!(ropts->flags & CAN_RAW_XL_VCID_TX_PASS))
> +                       cxl->vcid = 0;
> +
> +               /* set VCID in CAN XL frame if enabled */
> +               if (ropts->flags & CAN_RAW_XL_VCID_TX_SET)
> +                       cxl->vcid = ropts->tx_vcid;

Just in terms of software design, I am not sure why this sanitization
is part of raw_bad_txframe(). The purpose of this function is, so far,
to just return a boolean telling whether or not the frame is valid. It
is surprising to repurpose this to also do the sanitization. I would
rather see the above code go in a new dedicated function (maybe
raw_sanitize_tx_frame()) and call that new function from
raw_sendmsg().

>                 return false;
> +       }
>
>         return true;
>  }
>
>  static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
> --
> 2.39.2
>
>

