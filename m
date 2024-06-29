Return-Path: <linux-can+bounces-894-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442991CBE7
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 11:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F2E283560
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01272033E;
	Sat, 29 Jun 2024 09:32:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F01C20
	for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719653524; cv=none; b=Awe+DofZ1METfIyvMWjE3AEnicuWFpb3qko+3AJDUfMPpNDnL+8kE5nQouLxP+CB2Kz2IeEvdmyGaJTxUWh2ZwsSdKvqjpXrLzjuuPzgyLgsDFBY9hBUheLjBG4QOCBZElo/5qXeMk3LTGI8vmiOgxWF/k5RSgJL2Zu9anVP0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719653524; c=relaxed/simple;
	bh=F7lJHBjbgnZL00j4F0V+IXBUarox4Ru+UtUSQyegMMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3WefCLL9E8SmfYppEQ6Ml+mTfX56V+a9ivrSZTGpkzNDAsXKY3+gF5vDgBUnwDhKtp7NZU+i7hA4HHIYzJCxNu78la8+N7/Vp2waxC1GjF7Jnnxqpn8iuPGTMLfAX09TnKjmhTLouRlrRG74QF1v5n0V50HhuCbccQo4sxFsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c8e7553c9eso1008288a91.3
        for <linux-can@vger.kernel.org>; Sat, 29 Jun 2024 02:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719653522; x=1720258322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAbu2aDJzESiTc2Zw2M/zATdvnOQfFy8V566rlbdvbQ=;
        b=vFZtPwFnIWgy/tlTjl1MXvgIldzG/OKYuYTSmD/EjvIKVRCPqDKOYIG5lAptZEdgHh
         ctE2q1p0McsyBVAMaARj8IAHnfsPQbR4S6RDF/SC05j/McGfPF5OuzLtM7h3NdzZrPCM
         BkuFMqzu/M1hhrqYYIFQDCOy6YfC39iCNSdDSObQAKcbVMIB8JM+g5rsosgQ4u9Aga8Y
         oEcHS5ibTMq4g+ic/VDDv7Hg+kb3sfRT0Rp6Jn+4krlUi6OumH59wR3ZbNEoSpXfExnh
         EDUVFlICTh+0fo927plhDNvfTDEJIUFyprd6fUtibgGTC9PRt57xOGodLVt2ln2giLV/
         E0vA==
X-Gm-Message-State: AOJu0YwXv6m5RwGwzkoxYiCmdXTlJN9/v9TvSYR8TsCHh+rctVDBWPD5
	gaoCbJTu1DU92zhzOMARz/kYjB4NYTzJd5Ru3jOhKAqF5RVncCK7C50mDG4mLzCrKY+XwIamgjH
	ZBEygywH4CvLjaUM/jjqcRTStmaj4f08s
X-Google-Smtp-Source: AGHT+IGDUN8XREGQdTzEX6Mig6XLZOviMFe0MpSPjKYI/oE4GeJkHs7QWXOqk4Hnh6OXTG511yDOyeHHcDhbxgY9htw=
X-Received: by 2002:a17:90b:3a8e:b0:2c9:321:1bf1 with SMTP id
 98e67ed59e1d1-2c93d775a7amr397744a91.39.1719653522015; Sat, 29 Jun 2024
 02:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628195514.316895-1-extja@kvaser.com> <20240628195514.316895-3-extja@kvaser.com>
In-Reply-To: <20240628195514.316895-3-extja@kvaser.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sat, 29 Jun 2024 18:31:50 +0900
Message-ID: <CAMZ6RqKSa-6KjvgfmN9eL7A=A65gMkYsRrnaF41Azhsc45FA2Q@mail.gmail.com>
Subject: Re: [PATCH can-next 02/15] can: kvaser_usb: hydra: Add struct for Tx
 ACK commands
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Sat. 29 June 2024 at 04:56, Jimmy Assarsson <extja@kvaser.com> wrote:
> Add, struct kvaser_cmd_tx_ack, for standard Tx ACK commands.
>
> Expand kvaser_usb_hydra_ktime_from_cmd() to extract timestamps from both
> standard and extended Tx ACK commands. Unsupported commands are silently
> ignored, and 0 is returned.
>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index a971fcb6158a..0be1cfe8d964 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -261,6 +261,15 @@ struct kvaser_cmd_tx_can {
>         u8 reserved[11];
>  } __packed;
>
> +struct kvaser_cmd_tx_ack {
> +       __le32 id;
> +       u8 data[8];
> +       u8 dlc;
> +       u8 flags;
> +       __le16 timestamp[3];
> +       u8 reserved0[8];
> +} __packed;
> +
>  struct kvaser_cmd_header {
>         u8 cmd_no;
>         /* The destination HE address is stored in 0..5 of he_addr.
> @@ -297,6 +306,7 @@ struct kvaser_cmd {
>
>                 struct kvaser_cmd_rx_can rx_can;
>                 struct kvaser_cmd_tx_can tx_can;
> +               struct kvaser_cmd_tx_ack tx_ack;
>         } __packed;
>  } __packed;
>
> @@ -525,16 +535,23 @@ kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
>  static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *cfg,
>                                                const struct kvaser_cmd *cmd)
>  {
> -       u64 ticks;
> +       u64 ticks = 0;
>
>         if (cmd->header.cmd_no == CMD_EXTENDED) {
>                 struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
>
> -               ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
> -       } else {
> +               if (cmd_ext->cmd_no_ext == CMD_RX_MESSAGE_FD)
> +                       ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
> +               else if (cmd_ext->cmd_no_ext == CMD_TX_ACKNOWLEDGE_FD)
> +                       ticks = le64_to_cpu(cmd_ext->tx_ack.timestamp);
> +       } else if (cmd->header.cmd_no == CMD_RX_MESSAGE) {
>                 ticks = le16_to_cpu(cmd->rx_can.timestamp[0]);
>                 ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[1])) << 16;
>                 ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[2])) << 32;
> +       } else if (cmd->header.cmd_no == CMD_TX_ACKNOWLEDGE) {
> +               ticks = le16_to_cpu(cmd->tx_ack.timestamp[0]);
> +               ticks += (u64)(le16_to_cpu(cmd->tx_ack.timestamp[1])) << 16;
> +               ticks += (u64)(le16_to_cpu(cmd->tx_ack.timestamp[2])) << 32;

Nitpick: the conversion of teh timestamp[3] array to the u64 tick is
now duplicated. Maybe worth adding a

  kvaser_usb_hydra_convert_timestamp_to_ktime(__le16 *timestamp, u64 ticks);

helper function to factorize this and the ns_to_ktime() all together?

If you do so, it is better to add the new patch before this one.

>         }
>
>         return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
> --
> 2.45.2
>
>

