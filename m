Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD84F2A48E3
	for <lists+linux-can@lfdr.de>; Tue,  3 Nov 2020 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgKCPEC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Nov 2020 10:04:02 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36271 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgKCPEB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 10:04:01 -0500
Received: by mail-yb1-f194.google.com with SMTP id f140so15113337ybg.3
        for <linux-can@vger.kernel.org>; Tue, 03 Nov 2020 07:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3TuKm2nt7+D0HGHjkCYl0QVjuhNrGgPoWFxn31J74Q=;
        b=ueR5YZT7/yKMGAHKe98uUbhZ3qOfzgw3GMPOo0JsqnyimtwOukHQVr1JWcXZIISNZG
         OXM/rgvzgNsLEnF10jidlkmD8ztqJefbI178LuZJ9JYidpq1R4/oAEEZRPY9oDwFgEPz
         4QjeUKoLmnk3cf0GKlJlvd4f+0VDsiAh+JJ/ZUgP2sGkIWhI1CwuqNCE15fyBVzBOjfQ
         7XNzBjs9T3hB+ZJ2b8cnkCiuvrZ1ZpNZ+T5oMhSfTzGtj7pi3EoFxVBOVLA0yGuJVesJ
         uDMLBXRplLngA/6R+Tr/ed/aH5g9TpZ+D4XfpaURh5XBzmLduVbPAt+zjc9dHOCKy7wo
         cPEg==
X-Gm-Message-State: AOAM531yUjCmvYZGQJvS+Kzxop9/3ZQnT99ViD27oNqGNS1p0EotQu5R
        WbSxe0orvc6Xn79N7gk9cPDjA/ZKVKdhf89G2bHAx+koYD8=
X-Google-Smtp-Source: ABdhPJx15JaagN0ksMCXyHy2+/o4oltCkmbUF8oEY1ZxcEdPlRT7SLvYLxatm32dnFkiXERv5N39JPQHYs7+jySgTlY=
X-Received: by 2002:a25:d46:: with SMTP id 67mr27068467ybn.360.1604415840349;
 Tue, 03 Nov 2020 07:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20201029083218.41505-1-socketcan@hartkopp.net> <20201029083218.41505-2-socketcan@hartkopp.net>
In-Reply-To: <20201029083218.41505-2-socketcan@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 4 Nov 2020 00:03:49 +0900
Message-ID: <CAMZ6Rq+NhTG8k0vbSsBHTRtFtRDZ62hUDLBHTMttOALkeG73mg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] can: add optional DLC element to Classical CAN
 frame structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 29.10.20 17:32, Oliver Hartkopp wrote:
>  /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
>  #define CANFD_MAX_DLC 15
>  #define CANFD_MAX_DLEN 64
>
>  /**
>   * struct can_frame - basic CAN frame structure

struct can_frame - Classical CAN frame structure.

This is just a nitpick but I was reading again the past email
exchanges and using "Classical CAN" instead of "basic CAN" here would
be more consistent and help people to better understand the CC
acronym.

> - * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
> - * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
> - *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
> - *           mapping of the 'data length code' to the real payload length
> - * @__pad:   padding
> - * @__res0:  reserved / padding
> - * @__res1:  reserved / padding
> - * @data:    CAN frame payload (up to 8 byte)
> + * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
> + * @len:      CAN frame payload length in byte (0 .. 8)
> + * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
> + * @__pad:    padding
> + * @__res0:   reserved / padding
> + * @len8_dlc: optional DLC value (9 .. 15) at 8 byte payload length
> + *            len8_dlc contains values from 9 .. 15 when the payload length is
> + *            8 bytes but the DLC value (see ISO 11898-1) is greater then 8.
> + *            CAN_CTRLMODE_CC_LEN8_DLC flag has to be enabled in CAN driver.
> + * @data:     CAN frame payload (up to 8 byte)
>   */
>  struct can_frame {
>         canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> -       __u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
> -       __u8    __pad;   /* padding */
> -       __u8    __res0;  /* reserved / padding */
> -       __u8    __res1;  /* reserved / padding */
> -       __u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
> +       union {
> +               /* CAN frame payload length in byte (0 .. CAN_MAX_DLEN)
> +                * was previously named can_dlc so we need to carry that
> +                * name for legacy support
> +                */
> +               __u8 len;
> +               __u8 can_dlc; /* deprecated */
> +       };
> +       __u8 __pad; /* padding */
> +       __u8 __res0; /* reserved / padding */
> +       __u8 len8_dlc; /* optional DLC for 8 byte payload length (9 .. 15) */
> +       __u8 data[CAN_MAX_DLEN] __attribute__((aligned(8)));
>  };

Yours sincerely,
Vincent Mailhol
