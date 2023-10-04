Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19617B7D8B
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjJDKvO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 06:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjJDKvO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 06:51:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671BBBD
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 03:51:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-279294d94acso634274a91.0
        for <linux-can@vger.kernel.org>; Wed, 04 Oct 2023 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696416669; x=1697021469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WwpZGn0NVSOuCUHXbthrrnVfjoYA2AAv/0Qv9r+wq/4=;
        b=Im9fAwxigCatVzrCphoO6sIpplx8hwGyiAr08yjC32RBxSJPx9qJ0CADXL5zWDmbZH
         Wp2HKvCqx8qn3sV3NWrb6SXuL+cr9epJz47X57HhNIk6FhK/u39wXY7+SawL0zffPIZV
         GUvjfRAKPWccywXTTt0mF9qtkJz3HLIDVl0Ofu9cGRGuMvjkwCWJcwUEzyuN2U62XX66
         aP2UjgEqQt2akO6+EdJ7r90GMfNkIWsPO4v9cr4o98lOVlFdMz80b8Ig44GG/jB8tOd/
         TiR4R5uEzC234BFb0uV0RCIQNc8rqn/D13Jb/P5VDHxhwpkQo4vHZwbGJKFIbQMiFTNH
         ZUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696416669; x=1697021469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwpZGn0NVSOuCUHXbthrrnVfjoYA2AAv/0Qv9r+wq/4=;
        b=B9tlvHSx70DCP621IuIvpEclICObE0JlU3uJB08QDVCxk4mFAQtaUkJbW65dBNdAEM
         3wEgHlAtomxFYndExJS7gSVTJtQYAmJDzQtcWMmCinqYGb8tm8a+PJTMex2ncVdl8kym
         xU07xPkehOhYV2TLPdbCTRY/WfMRAv3d7kMIzfh49/sssYiddErw38u5RTV1uha3THc4
         LOhDeG8xpnOYTCE2GZk/LHbsapfZYQ0RUJWFdVuvTbSLr+BoYE9aHTrCYEQHNz9uR5D0
         WMMdv04JvBUlqYpJCmJiG/3ljkJHqdJj4/4WGBBQz4KB+k/C3X3F2E24VIQ7/BcGc/uD
         rGTw==
X-Gm-Message-State: AOJu0YxgUR+n7/LeyG6QwFWqkjfz84YVZ1OtCnoxP7RMw6MhHZ26sIc5
        C1bCye52eWwD6o1VbfgQzvt/yyvQ1p06MxG02zsMtxz4oVg=
X-Google-Smtp-Source: AGHT+IFtAcE2RtpHSLOcPUkjvI1uPVuvypS2AlndBqxZ6FfFlnYcijGqME/Nlb/+lJEPRiQ9+in1iqgUcjpWCtzGlSM=
X-Received: by 2002:a17:90b:1d04:b0:268:808:8e82 with SMTP id
 on4-20020a17090b1d0400b0026808088e82mr2944252pjb.1.1696416668724; Wed, 04 Oct
 2023 03:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de> <20231004-at91_can-rx_offload-v1-1-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-1-c32bf99097db@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 4 Oct 2023 19:50:55 +0900
Message-ID: <CAMZ6RqL7EUeYeBB3XUvZeL=bMNzSOPSEoTB7R5D8CTLFz1n+Mg@mail.gmail.com>
Subject: Re: [PATCH 01/27] can: dev: add can_state_get_by_berr_counter() to
 return the CAN state based on the current error counters
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 4 Oct. 2023, 18:24, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Some CAN controllers do not have a register that contains the current
> CAN state, but only a register that contains the error counters.
>
> Introduce a new function can_state_get_by_berr_counter() that returns
> the current TX and RX state depending on the provided CAN bit error
> counters.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/dev.c | 22 ++++++++++++++++++++++
>  include/linux/can/dev.h   |  4 ++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 7f9334a8af50..6242424fadbc 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -90,6 +90,28 @@ const char *can_get_state_str(const enum can_state state)
>  }
>  EXPORT_SYMBOL_GPL(can_get_state_str);
>
> +static enum can_state can_state_err_to_state(u16 err)
> +{
> +       if (err < 96)
> +               return CAN_STATE_ERROR_ACTIVE;
> +       if (err < 128)
> +               return CAN_STATE_ERROR_WARNING;
> +       if (err < 256)
> +               return CAN_STATE_ERROR_PASSIVE;

Please use the macros from include/uapi/linux/can/error.h.

  https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can/error.h#L130

> +       return CAN_STATE_BUS_OFF;
> +}
> +
> +void can_state_get_by_berr_counter(const struct net_device *dev,
> +                                  const struct can_berr_counter *bec,
> +                                  enum can_state *tx_state,
> +                                  enum can_state *rx_state)
> +{
> +       *tx_state = can_state_err_to_state(bec->txerr);
> +       *rx_state = can_state_err_to_state(bec->rxerr);
> +}
> +EXPORT_SYMBOL_GPL(can_state_get_by_berr_counter);
> +
>  void can_change_state(struct net_device *dev, struct can_frame *cf,
>                       enum can_state tx_state, enum can_state rx_state)
>  {
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 982ba245eb41..1b92aed49363 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -195,6 +195,10 @@ int can_restart_now(struct net_device *dev);
>  void can_bus_off(struct net_device *dev);
>
>  const char *can_get_state_str(const enum can_state state);
> +void can_state_get_by_berr_counter(const struct net_device *dev,
> +                                  const struct can_berr_counter *bec,
> +                                  enum can_state *tx_state,
> +                                  enum can_state *rx_state);
>  void can_change_state(struct net_device *dev, struct can_frame *cf,
>                       enum can_state tx_state, enum can_state rx_state);
