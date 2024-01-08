Return-Path: <linux-can+bounces-115-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307AC8267CB
	for <lists+linux-can@lfdr.de>; Mon,  8 Jan 2024 06:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA94281803
	for <lists+linux-can@lfdr.de>; Mon,  8 Jan 2024 05:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62278BE3;
	Mon,  8 Jan 2024 05:47:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA08BED
	for <linux-can@vger.kernel.org>; Mon,  8 Jan 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28cf8de47e3so357984a91.3
        for <linux-can@vger.kernel.org>; Sun, 07 Jan 2024 21:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704692823; x=1705297623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qruIEmNWNrBaZ1FxvGLRS9wRa0ijMn1ob9EhD7E9v8M=;
        b=vjBDwmOcf25tVQxfztAr+y8W/Qco6UFVD4+s7IfKwpYt0P7NHbnjUosounCPYDtHKY
         LTmCNqfjzups5vbSDkW/UjbzxKCEjAdqDfb4rQOjVVneCreurdU91Gi4wMjONAoaS9H6
         e0XbwJ9iUbCgaSMeCn67jLiQx/lxE+wBR2nJlv4CmfVTnUqNCn25BySf857JuUxqRwY/
         MSoT5gTPR1Z8AQgVRxgA3iqevjQMMjJ7M5qazt008QQrEtVIwge6+ObXhH7+t1KQhiaa
         aS3lEfS53T4KiZtQ2qXsbrZrbcBb2XrOpg+xct+hz0TcCmITANVtEGZJWernF63BGOfa
         Ug9Q==
X-Gm-Message-State: AOJu0YwX9JnNPSrLfcsgbP9xqp7ITTGf92YxWsdyvZwxhRtJVyTvOTGq
	xIDoY5xLoQzq6IrbeX3d8Wq583AF7KsmbQKPQw63rjHBFwPb/Q==
X-Google-Smtp-Source: AGHT+IFJKBp6SuhNaX87r+/a1EgHkbhTZ21pxQcKvZBiK0eprx1mFCmBM1hVS0ZXcLZW2gQEKr07NOx+tOpGRWm/ZqY=
X-Received: by 2002:a17:90a:fe97:b0:28b:eaa5:7986 with SMTP id
 co23-20020a17090afe9700b0028beaa57986mr646898pjb.95.1704692822268; Sun, 07
 Jan 2024 21:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107171401.2339-1-socketcan@hartkopp.net>
In-Reply-To: <20240107171401.2339-1-socketcan@hartkopp.net>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Mon, 8 Jan 2024 14:46:50 +0900
Message-ID: <CAMZ6RqKoAyh_ow_rsPWMqe_jzQkAjvBitzHPY6-G4YhyEqw7ag@mail.gmail.com>
Subject: Re: [PATCH v3] canxl: add virtual CAN network identifier support
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

Hi Oliver,

Thanks for addressing my comments. Nice improvement from v1. The
headers look overall good. Here is a nitpicking review.

I have not yet reviewed the net/can/raw.c part. It will take me more
time. I will do it later (we are the first day of the merge window, so
that leaves me time!)

On Mon. 8 Jan 2024 at 02:14, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
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
> to the user space.
>

Question: do you think this should also go to stable?

> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/uapi/linux/can.h     | 39 ++++++++++++++-------
>  include/uapi/linux/can/raw.h | 14 ++++++++
>  net/can/af_can.c             |  2 ++
>  net/can/raw.c                | 66 ++++++++++++++++++++++++++++++++++--
>  4 files changed, 105 insertions(+), 16 deletions(-)
>
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 939db2388208..b20268a944e6 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h

More a matter of principle, but you should

  #include <asm/byteorder.h>

c.f. https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ip.h#L22

> @@ -193,26 +193,39 @@ struct canfd_frame {
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
> + * @prio:   11 bit arbitration priority with zero'ed CAN_*_FLAG flags

Now that prio is a __u16, the CAN_*_FLAG flags fall outside prio width
(in __res0 as you mentioned below). So I would rather remove the
latter part of this sentence. You may instead specify that bits
outside of the CANXL_PRIO_MASK shall be zeroed.

> + * @vcid:   virtual CAN network identifier

Maybe say that this field is valid only if enabled through
CAN_RAW_XL_VCID_OPTS, else should be zero.

> + * @__res0: reserved / padding must be set to 0
> + * @flags:  additional flags for CAN XL
> + * @sdt:    SDU (service data unit) type
> + * @len:    frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
> + * @af:     acceptance field
> + * @data:   CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
>   *
> - * @prio shares the same position as @can_id from struct can[fd]_frame.
> + * @prio shares the lower 16 bits of @can_id from struct can[fd]_frame.
> + * @__res0 holds the @can_id flags CAN_xxx_FLAG and has to be set to zero

Just realized now, but I would have personally preferred to merge
those two sentences within their respective field documentation. Just
feels odd to me to have the information on the prio and __res0 field
are scattered in two different locations. Well this is just a nitpick,
at the end, just choose which one seems good to you.

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
> +       __u8  __res0; /* reserved / padding must be set to 0 */
> +#elif defined(__BIG_ENDIAN)
> +       __u8  __res0; /* reserved / padding must be set to 0 */
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
> index 31622c9b7988..8890b0d2fd48 100644
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
> +struct can_raw_vcid_options {
> +
> +       __u8 flags;             /* flags for vcid (filter) behaviour */
> +       __u8 tx_vcid;           /* VCID value set into canxl_frame.prio */
> +       __u8 rx_vcid;           /* VCID value for VCID filter */
> +       __u8 rx_vcid_mask;      /* VCID mask for VCID filter */
> +

Why the newlines before and after the struct members? This style is
not consistent with the other CAN headers.

> +};
> +
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

Nitpick: I would expect to see the code structured in this order:
check Classical CAN first, then CAN-FD and finally CAN-XL. Not sure
why the CAN-XL is in the middle. If the only reason is to minimize the
patch diff, then no.

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
> +
>                 return false;
> +       }
>
>         return true;
>  }
>
>  static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
> --
> 2.34.1
>
>

