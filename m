Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEA92A493D
	for <lists+linux-can@lfdr.de>; Tue,  3 Nov 2020 16:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgKCPRv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Nov 2020 10:17:51 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40669 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgKCPRt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 10:17:49 -0500
Received: by mail-yb1-f195.google.com with SMTP id n142so15141978ybf.7
        for <linux-can@vger.kernel.org>; Tue, 03 Nov 2020 07:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBubPoLIb4Q8HX9ifkToeweWqZ6MQnSgVnq4pepeXTQ=;
        b=TmcQilw0wP9EqqcpEDOo31RmlRy2bd2GuV37VuHOeVYE/6x2X4VFjbbBE/B6OFk2XW
         PTLqBSlOwnYVYhkYZ3xH1i2lERDbVDs5FlJWCU2Lf561DlvhMZk/08JfU6C/IMucbFpp
         2o+kE30liHuRSO8VZp3sLiXhX8IKSb1Gh3uD50RVLZtNTCHnhdH7EjzD3lcl6QZct/sI
         SqeZYGbJSAttxdmki3b3kck2kKZuumrWjNcIs+1XQB3cKHVLrrp1JrA/XwwsmhJTmxXM
         B+NhcuzRzLXPnkU5QdkpGerH9gRr8nlYzG5I3HyPRiYbMp1rFz/GF4Kp5BiYtxHy7LKL
         Tz4g==
X-Gm-Message-State: AOAM530aydZmnUNXcjH5T94thQC29Aztg7XZYH1pbUzCVT9CKOtlgCbz
        NzTj91XfWlGKhbIjKf4rCC90Y7LgNviEYAPJPu8=
X-Google-Smtp-Source: ABdhPJxFawK21GQuG2z4iOmpie4/4D4bTJUiKAjPMl8EsO/Ji3nuEu1L0bHLBgYUoZcOkUrRytrJUF79c8aVEAFdhQ0=
X-Received: by 2002:a25:c782:: with SMTP id w124mr30532564ybe.125.1604416667705;
 Tue, 03 Nov 2020 07:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20201029083218.41505-1-socketcan@hartkopp.net> <20201029083218.41505-3-socketcan@hartkopp.net>
In-Reply-To: <20201029083218.41505-3-socketcan@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 4 Nov 2020 00:17:36 +0900
Message-ID: <CAMZ6RqL4LTtBJrEnRXzz7wTmGu+8B5D=ZM=PRPjfaR=raXGDhw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] can: rename get_can_dlc() macro with can_get_cc_len()
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 29.10.20 17:32, Oliver Hartkopp wrote:
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 41ff31795320..0a51f3c9cfec 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -96,17 +96,17 @@ static inline unsigned int can_bit_time(const struct can_bittiming *bt)
>  {
>         return CAN_SYNC_SEG + bt->prop_seg + bt->phase_seg1 + bt->phase_seg2;
>  }
>
>  /*
> - * get_can_dlc(value) - helper macro to cast a given data length code (dlc)
> + * can_get_cc_len(value) - helper macro to cast a given data length code (dlc)
>   * to u8 and ensure the dlc value to be max. 8 bytes.

 * can_get_cc_len(value) - convert a given data length code (dlc) of a
 * Classical CAN frame into a valid data length of max. 8 bytes.

The comment is a leftover. It still mentioned DLC of max. 8 bytes. I
tried to rephrase it to better highlight the nuance.

>   *
>   * To be used in the CAN netdriver receive path to ensure conformance with
>   * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
>   */
> -#define get_can_dlc(i)         (min_t(u8, (i), CAN_MAX_DLC))
> +#define can_get_cc_len(i)      (min_t(u8, (i), CAN_MAX_DLEN))

#define can_get_cc_len(dlc)      (min_t(u8, (dlc), CAN_MAX_DLEN))

It is easier to read and understand if the input is named "dlc", not "i".

>  #define get_canfd_dlc(i)       (min_t(u8, (i), CANFD_MAX_DLC))
>
>  /* Check for outgoing skbs that have not been created by the CAN subsystem */
>  static inline bool can_skb_headroom_valid(struct net_device *dev,
>                                           struct sk_buff *skb)


Yours sincerely,
Vincent Mailhol
