Return-Path: <linux-can+bounces-109-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14874826323
	for <lists+linux-can@lfdr.de>; Sun,  7 Jan 2024 07:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B176928299F
	for <lists+linux-can@lfdr.de>; Sun,  7 Jan 2024 06:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762BD125BA;
	Sun,  7 Jan 2024 06:28:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1E125B8
	for <linux-can@vger.kernel.org>; Sun,  7 Jan 2024 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbb4806f67so1004648b6e.3
        for <linux-can@vger.kernel.org>; Sat, 06 Jan 2024 22:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704608931; x=1705213731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCYoHkGqa5opNGcufMpnBKnHJqvkMU98cDEM556/SgE=;
        b=FFF/L5be0r7ijqcScofcXak8aigHlhnOYfUYPy0MqMs62Y0TBNducqmbyfddeeXrHl
         u3AtQp0EUjaeR/HKwq40qPm9pjmOkMjnLFAcAneHcNFKZw1hUKjZ6OPCzXWrLjR8Eldq
         vmzN+esbwhjST/oDASVPbZ4I/ZXZ+upw+wce6EL/Qf4xV2IfGaV0ymGkJg1B4gtKnOvf
         d3iNuGtv5a3qnKrHbFLroQTMD8kI3Kg2ecD04yyYjUd5FfSARhBdpuOzeggyF9A/mLn9
         vuUMhGSHAl8ac+GSLVS8m6lPTA/joFy2O+s6d+G4Kt0M3+vAGqvCEkq1l/zZcqgZXrd+
         VmCA==
X-Gm-Message-State: AOJu0YzEyRp6hFEpI25rognmvYJmO965LOedqPw7bxZl5Ay6uhWRjEk0
	HrrqSMcRD2ubu9+mHkQiQD6p5I9v3eqH8jq1swc=
X-Google-Smtp-Source: AGHT+IGcMt6TLg6pKTUA99dZlwcAtFSeHCw3b4t6HwLYPJUG5N1qkWLBQE2Buz3pGYYprJBR4wCu/Vk8bPG8J2zTMQA=
X-Received: by 2002:a05:6358:528f:b0:175:45cf:ea04 with SMTP id
 g15-20020a056358528f00b0017545cfea04mr2127139rwa.33.1704608931337; Sat, 06
 Jan 2024 22:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106192836.4716-1-socketcan@hartkopp.net>
In-Reply-To: <20240106192836.4716-1-socketcan@hartkopp.net>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 7 Jan 2024 15:28:25 +0900
Message-ID: <CAMZ6Rq+S7mUWBXQEm2uHTKt31Z5JBj1LK2WNpN7pwujx5DhSzw@mail.gmail.com>
Subject: Re: [PATCH] canxl: add virtual CAN network identifier support
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

On Sun. 7 Jan. 2024 at 04:47, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
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
> values can be send, e.g. to replay full qualified CAN XL traffic.
                ^^^^

sent

>
> The VCID value provided for the CAN_RAW_XL_VCID_TX_SET option will
> override the VCID value in the struct canxl_frame.prio defined for
> CAN_RAW_XL_VCID_TX_PASS when both flags are set.
>
> With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are passed
> to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set. Without this
> flag only untagged CAN XL frames (VCID = 0x00, CANXL_VCID flag unset) are
> delivered to the user space.
>
> The 8-bit VCID is stored inside the CAN XL prio element (only in CAN XL
> frames!) to not interfere with other CAN content or the CAN filters
> provided by the CAN_RAW sockets and kernel infrastruture.
                                             ^^^^^^^^^^^^^

infrastructure

>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/uapi/linux/can.h     | 14 +++++--
>  include/uapi/linux/can/raw.h | 14 +++++++
>  net/can/raw.c                | 79 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 100 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 939db2388208..30453905fbd2 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -180,34 +180,40 @@ struct canfd_frame {
>  };
>
>  /*
>   * defined bits for canxl_frame.flags
>   *
> - * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
> - * and shares the relative position of the struct can[fd]_frame.len element.
> + * The canxl_frame.flags element contains CAN XL frame specific bits and
> + * shares the relative position of the struct can[fd]_frame.len element.
>   * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
>   * As a side effect setting this bit intentionally breaks the length checks
>   * for Classical CAN and CAN FD frames.
>   *
>   * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
>   */
>  #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
>  #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
> +#define CANXL_VCID 0x02 /* prio contains the virtual CAN network identifier */
> +
> +/* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
> +#define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */
> +#define CANXL_VCID_VAL_MASK 0xFFUL /* VCID is an 8-bit value */
> +#define CANXL_VCID_MASK (CANXL_VCID_VAL_MASK << CANXL_VCID_OFFSET)
>
>  /**
>   * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
> - * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags / VCID
>   * @flags: additional flags for CAN XL
>   * @sdt:   SDU (service data unit) type
>   * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
>   * @af:    acceptance field
>   * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
>   *
>   * @prio shares the same position as @can_id from struct can[fd]_frame.
>   */
>  struct canxl_frame {
> -       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> +       canid_t prio;  /* 11 bit priority for arbitration / 8 bit VCID */

Isn't this a UAPI breaking change? Prior to this patch, the applications may do:

  canxl_frame.prio

to get the prio, but after this patch, applications are required to do:

  canxl_frame.prio & CANXL_PRIO_MASK

in order to mask out the VCID (currently, there are no requirements
that canxl_frame.prio must be masked before use).
In the past, I was reluctant to acknowledge the introduction of CANXL
in the kernel prior to reading the ISO standard because I was afraid
of such UAPI stability issues. Now we have to deal with it.

What do you think of:

  struct canxl_frame {
  #if defined(__LITTLE_ENDIAN)
          __u16 prio;  /* 11 bit priority for arbitration */
          __u8 vcid; /* 8 bit VCID */
          __u8 __reserved; /* must be 0 */
         /* ... */
  #elif defined(__BIG_ENDIAN)
          __u8 __reserved; /* must be 0 */
          __u8 vcid; /* 8 bit VCID */
          __u16 prio;  /* 11 bit priority for arbitration */
  #else
  #error "Unknown endianness"
  #endif
  }

Here, canxl_frame.prio always gives a correct value without need for
CANXL_PRIO_MASK masking. The big/little endianness checks are needed
to maintain the ABI compatibility. Not yet tested, so forgive if there
is a mistake. Getting the endianness logic correct on a first try is
not easy.

Also, the VCID can now be accessed through canxl_frame.vcid instead of
relying on some mask and shift logic.

The drawback is that you lose the can_id type. For what I understand,
this is only used for filtering. If we absolutely need to maintain the
canid_t, then maybe:

  struct canxl_frame {
          union {
                  canid_t filter;
                  struct {
  #if defined(__LITTLE_ENDIAN)
                          __u16 prio;  /* 11 bit priority for arbitration */
                          __u8 vcid; /* 8 bit VCID */
                          __u8 __reserved; /* must be 0 */
  #elif defined(__BIG_ENDIAN)
                          __u8 __reserved; /* must be 0 */
                          __u8 vcid; /* 8 bit VCID */
                          __u16 prio;  /* 11 bit priority for arbitration */
  #else
  #error "Unknown endianness"
  #endif
                  };
          };
         /* ... */
  }

But I think it is better to drop it. If someone wants a canid_t, then
he or she can just cast the XL frame to either struct can_frame or
struct canfd_frame.

Though?

>         __u8    flags; /* additional flags for CAN XL */

If CANXL_VCID is set, can vcid be zero? If not, no need for a flag.
Just need to check if canxl_frame.vcid is not zero.

>         __u8    sdt;   /* SDU (service data unit) type */
>         __u16   len;   /* frame payload length in byte */
>         __u32   af;    /* acceptance field */
>         __u8    data[CANXL_MAX_DLEN];
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
> +};
> +
> +#define CAN_RAW_XL_VCID_TX_SET         0x01
> +#define CAN_RAW_XL_VCID_TX_PASS                0x02
> +#define CAN_RAW_XL_VCID_RX_FILTER      0x04
> +
>  #endif /* !_UAPI_CAN_RAW_H */
> diff --git a/net/can/raw.c b/net/can/raw.c
> index e6b822624ba2..a6f0b6a0a934 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -89,10 +89,14 @@ struct raw_sock {
>         struct list_head notifier;
>         int loopback;
>         int recv_own_msgs;
>         int fd_frames;
>         int xl_frames;
> +       struct can_raw_vcid_options raw_vcid_opts;
> +       canid_t tx_vcid_shifted;
> +       canid_t rx_vcid_shifted;
> +       canid_t rx_vcid_mask_shifted;
>         int join_filters;
>         int count;                 /* number of active filters */
>         struct can_filter dfilter; /* default/single filter */
>         struct can_filter *filter; /* pointer to filter(s) */
>         can_err_mask_t err_mask;
> @@ -132,14 +136,33 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
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
> +
> +               /* make sure to not pass oversized frames to the socket */
> +               if (!ro->xl_frames)
> +                       return;
> +
> +               /* filter CAN XL VCID content */
> +               if (ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_RX_FILTER) {
> +                       /* apply VCID filter if user enabled the filter */
> +                       if ((cxl->prio & ro->rx_vcid_mask_shifted) !=
> +                           (ro->rx_vcid_shifted & ro->rx_vcid_mask_shifted))
> +                               return;
> +               } else {
> +                       /* no filter => do not forward VCID tagged frames */
> +                       if (cxl->prio & CANXL_VCID_MASK)
> +                               return;
> +               }
> +       }
> +
>         /* eliminate multiple filter matches for the same skb */
>         if (this_cpu_ptr(ro->uniq)->skb == oskb &&
>             this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
>                 if (!ro->join_filters)
>                         return;
> @@ -696,10 +719,23 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
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
> +               /* prepare 32 bit values for handling in hot path */
> +               ro->tx_vcid_shifted = ro->raw_vcid_opts.tx_vcid << CANXL_VCID_OFFSET;
> +               ro->rx_vcid_shifted = ro->raw_vcid_opts.rx_vcid << CANXL_VCID_OFFSET;
> +               ro->rx_vcid_mask_shifted = ro->raw_vcid_opts.rx_vcid_mask << CANXL_VCID_OFFSET;
> +               break;
> +
>         case CAN_RAW_JOIN_FILTERS:
>                 if (optlen != sizeof(ro->join_filters))
>                         return -EINVAL;
>
>                 if (copy_from_sockptr(&ro->join_filters, optval, optlen))
> @@ -784,10 +820,25 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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
> @@ -814,12 +865,34 @@ static bool raw_bad_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
>             (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>                 return false;
>
>         /* CAN XL -> needs to be enabled and a CAN XL device */
>         if (ro->xl_frames && can_is_canxl_skb(skb) &&
> -           can_is_canxl_dev_mtu(mtu))
> +           can_is_canxl_dev_mtu(mtu)) {
> +               struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
> +
> +               /* sanitize non CAN XL bits */
> +               cxl->prio &= (CANXL_PRIO_MASK | CANXL_VCID_MASK);
> +
> +               /* clear VCID in CAN XL frame if pass through is disabled */
> +               if (!(ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_TX_PASS))
> +                       cxl->prio &= CANXL_PRIO_MASK;
> +
> +               /* set VCID in CAN XL frame if enabled */
> +               if (ro->raw_vcid_opts.flags & CAN_RAW_XL_VCID_TX_SET) {
> +                       cxl->prio &= CANXL_PRIO_MASK;
> +                       cxl->prio |= ro->tx_vcid_shifted;
> +               }
> +
> +               /* set flag only for 'tagged' VCID values */
> +               if (cxl->prio & CANXL_VCID_MASK)
> +                       cxl->flags |= CANXL_VCID;
> +               else
> +                       cxl->flags &= ~CANXL_VCID;
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

