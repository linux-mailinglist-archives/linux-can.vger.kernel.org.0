Return-Path: <linux-can+bounces-897-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D240391CBFA
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13D61C21183
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6D3A1B0;
	Sat, 29 Jun 2024 09:55:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36069445
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654951; cv=none; b=qrD5sk804IeotV1lVRV08RGTlIEsj9qlwYlQhdmW47+FgDwxDNs1giU6QFPqpaVeoSBTZr9pWTYiRs9JxlgpQArlc0fQT13OuMNUtaInCvErKBUk9ntE5Ah0bGxQoLi3kUA4yQB5gnXkZkz5sBDsJO9iJ37+KcCdroXeQ7vk3bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654951; c=relaxed/simple;
	bh=nNU/fQm+DA1KoCgAkOJISiJRmkNThAvaVqzH6Wq1J7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3E7Yd6WTSBFkjEr2zJZNnmyrgq6lVqVwyfiG+s7JDM13YMYjOjcro6HE+U57+iPXuw+0GzYz2FUSZyLfjwrToG4oSqaNC9//VlZVHLPOxSiOcnRQaIQlMXMItohcs78WxqnM/CIXhefx9Ppg19kHwDbKVB3d3l+UnyW/Vi9kf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c901185d73so1816149a91.0
        for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 02:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654949; x=1720259749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wS5OMWWZPm0oH7aO/+HLlsjU5sLC36sUWzlRYCQEHXI=;
        b=nNLGZDlsj9GkgclrrO+iy387wYryQ+7YlsdNhpJjFsS/VchCSRtPIffHjlkXhmhzst
         KOJTJtfheR83p3uvPNiVfWpflSrrbPoVQiuy1f2VzgQbUl7ulIFTkDBu/KR9tNgxmo+D
         CunA3eyczfrQ2a5eehKqur2L96K7h8IUrWqhfgaVpL7re25jpd6FbrxNHC5X6UCX5C27
         3oJluJxH2Eng/u2DOuH1Wre3BJSXIK86Y+rsHW13fNtPaeztpeYBPzjHISfBIx8U+qie
         Odcc9GUXrSd63+TJJGg3NUmSz6oUM5W5PvrvdWM1c570kLBRsjX8ZX1FKQ/2He1VHocm
         tZbg==
X-Gm-Message-State: AOJu0YxeOJ5wTKKOcI2bTeeNK8nf6vgaYsjUPfEePHw1d0wdOZmjbT7F
	SHENECKfhKBtGWGsQ4dqWnXuOYHx5r3muTjUGvn9YrzldiNfll3EkBNg6zoEFqLE02cOOwj4Hhi
	7TtZA1E+IzPVTTBC79HBWfU+S7qY=
X-Google-Smtp-Source: AGHT+IEGOzK6uGKsSvjec/YRFtCzJEerLlLpZicEz7yqLME+2VPxymVfQvknlsvUqcgdBkDwi6QV6pOVOgXAduIoRTU=
X-Received: by 2002:a17:90a:f406:b0:2c8:5055:e24f with SMTP id
 98e67ed59e1d1-2c93d1868d2mr1048267a91.2.1719654948925; Sat, 29 Jun 2024
 02:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628195514.316895-1-extja@kvaser.com> <20240628195514.316895-11-extja@kvaser.com>
In-Reply-To: <20240628195514.316895-11-extja@kvaser.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sat, 29 Jun 2024 18:55:37 +0900
Message-ID: <CAMZ6RqKqJX6eqogS2598BFm-AN1uOBbBGL+MkoJtR=-z379Q=w@mail.gmail.com>
Subject: Re: [PATCH can-next 10/15] can: kvaser_usb: leaf: Add structs for Tx
 ACK and clock overflow commands
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Sat. 29 June 2024 at 04:56, Jimmy Assarsson <extja@kvaser.com> wrote:
> For usbcan devices (M16C), add struct usbcan_cmd_tx_acknowledge for Tx ACK
> commands and struct usbcan_cmd_clk_overflow_event for clock overflow event
> commands.
>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 22 +++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index c0a8713d8cf2..98bd6cfca2ca 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -242,6 +242,13 @@ struct leaf_cmd_tx_acknowledge {
>         u8 padding[2];
>  } __packed;
>
> +struct usbcan_cmd_tx_acknowledge {
> +       u8 channel;
> +       u8 tid;
> +       __le16 time;
> +       u8 padding[2];
> +} __packed;
> +
>  struct leaf_cmd_can_error_event {
>         u8 tid;
>         u8 flags;
> @@ -288,6 +295,12 @@ struct usbcan_cmd_error_event {
>         __le16 padding;
>  } __packed;
>
> +struct usbcan_cmd_clk_overflow_event {
> +       u8 tid;
> +       u8 padding;
> +       __le32 time;
> +} __packed;
> +
>  struct kvaser_cmd_ctrl_mode {
>         u8 tid;
>         u8 channel;
> @@ -363,6 +376,8 @@ struct kvaser_cmd {
>                         struct usbcan_cmd_chip_state_event chip_state_event;
>                         struct usbcan_cmd_can_error_event can_error_event;
>                         struct usbcan_cmd_error_event error_event;
> +                       struct usbcan_cmd_tx_acknowledge tx_ack;
> +                       struct usbcan_cmd_clk_overflow_event clk_overflow_event;
>                 } __packed usbcan;
>
>                 struct kvaser_cmd_tx_can tx_can;
> @@ -396,15 +411,14 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
>         [CMD_START_CHIP_REPLY]          = kvaser_fsize(u.simple),
>         [CMD_STOP_CHIP_REPLY]           = kvaser_fsize(u.simple),
>         [CMD_GET_CARD_INFO_REPLY]       = kvaser_fsize(u.cardinfo),
> -       [CMD_TX_ACKNOWLEDGE]            = kvaser_fsize(u.tx_acknowledge_header),
> +       [CMD_TX_ACKNOWLEDGE]            = kvaser_fsize(u.usbcan.tx_ack),
>         [CMD_GET_SOFTWARE_INFO_REPLY]   = kvaser_fsize(u.usbcan.softinfo),
>         [CMD_RX_STD_MESSAGE]            = kvaser_fsize(u.usbcan.rx_can),
>         [CMD_RX_EXT_MESSAGE]            = kvaser_fsize(u.usbcan.rx_can),
>         [CMD_CHIP_STATE_EVENT]          = kvaser_fsize(u.usbcan.chip_state_event),
>         [CMD_CAN_ERROR_EVENT]           = kvaser_fsize(u.usbcan.can_error_event),
>         [CMD_ERROR_EVENT]               = kvaser_fsize(u.usbcan.error_event),
> -       /* ignored events: */
> -       [CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
> +       [CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
>  };
>
>  /* Summary of a kvaser error event, for a unified Leaf/Usbcan error
> @@ -1608,12 +1622,12 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
>                 kvaser_usb_leaf_get_busparams_reply(dev, cmd);
>                 break;
>
> -       /* Ignored commands */
>         case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
>                 if (dev->driver_info->family != KVASER_USBCAN)
>                         goto warn;
>                 break;

I did not understand this part. If the overflow event is now handled,
why do you still have the

  goto warn

?

Shouldn't you dispatch the command here?

> +       /* Ignored commands */
>         case CMD_FLUSH_QUEUE_REPLY:
>                 if (dev->driver_info->family != KVASER_LEAF)
>                         goto warn;
> --
> 2.45.2
>
>

