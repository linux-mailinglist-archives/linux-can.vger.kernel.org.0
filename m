Return-Path: <linux-can+bounces-4056-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12651B0EEC0
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 11:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED97F1890976
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFCE1DF756;
	Wed, 23 Jul 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="b+RorfZb"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79E153BE9
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264082; cv=none; b=Fw6B5WVOq1O5H/TIbAshaPl9Mw2whPrLE0ej2TVfIrqOp3B/NJlFfoFdmCIO7/n6rZqrRKvPwoE5+gXWM0vaBvDtFRb4FvuKYXMkKo61p05E6dcGibVJgtx/SB4yempEjlKxZtmz7IcU7kTJI0x/Kkl9Dh1STxgpuzjfA1+5WAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264082; c=relaxed/simple;
	bh=RptiQpfJ4emdu2E+LwtdOInpxCy3JS+rs7nO6eyXB/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPbuwsFDLrFEUUWrYm6e4e+1zVW52TMmMgHAWn1eU9A9dcuOO1kjfViSaokAbtuLmYCwCoNoCNQMWlhv/TCYSYy/C4Bv0EqopkRGitOhWwzvCPktE9VKSZs3gB89dVVK1BPHTK3cBCeI6GClOUYQQVh4H2RGnbnyE2KNRFh3krU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=b+RorfZb; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by smtp.orange.fr with ESMTPA
	id eW3huSZRFXbdFeW3hurBAB; Wed, 23 Jul 2025 11:46:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753264005;
	bh=IAW134j7FKy1j307NjgvtlKDQAJ4ZHmovlLEKhnfkwM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=b+RorfZbmWi1A1ZJNXMCbrje5rYvghobsL8+BXERyPRS3QG/9GjJZfo7YYf+p6vao
	 PZ+uZW+hvYoaixrE2R/jJp8E38qVJ5cIwg6MEKzZaiNd4EjlfumaPDWe5nxKGZvuBR
	 mGPbetkSyyZU57vq3GSx4OdzuGSVecRnjwJ3KAo0BTQLZHQJtwzp0+MgEL8dcldew9
	 vMERgVuyIBHpEJBcE8HhhNnCoO6LLa6oP7NQqBIT5cVIR0DgbLhhO8aNDweZlrW2VQ
	 LIZoyLjOpiRlFnfF1/McReEuKkhzx1UL8CZYdUaosj09W+NZyDImbmslHIP6eYvcfm
	 3Fw+0qyojKjMw==
X-ME-Helo: mail-ej1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 11:46:45 +0200
X-ME-IP: 209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aec46b50f33so1113334666b.3
        for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 02:46:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YyYgd/jhDzwKO99aJ6hOiJA9cjrsE24gZDgshmvOZ4XZIlkpvma
	0QCxKOZPX1HQM8Dlz5qzY1PJZVtIzcmBNkG/1yu77oD0/HSR0rDT8MPPG0paFt6kNNmZntzNNWr
	vKWqxYDl46wJVOvjtFjQq9uDzUUkVpOQ=
X-Google-Smtp-Source: AGHT+IEvSHGI7e4haAZFz5q3e1jffiNt5lm7haFTM4FFEO0pKN9GRCKJPsHvUnYAhUEOrXy2RHN9/tNdRkBgI7XjmnQ=
X-Received: by 2002:a17:906:c14d:b0:af1:d32f:3e89 with SMTP id
 a640c23a62f3a-af2f8666b87mr229257766b.31.1753264005253; Wed, 23 Jul 2025
 02:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723090255.36317-1-stephane.grosjean@hms-networks.com>
In-Reply-To: <20250723090255.36317-1-stephane.grosjean@hms-networks.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Wed, 23 Jul 2025 18:46:34 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+FH99xRNqndUVqFQwBMjutdrYsrvpJn_n6gTOC7zsAkg@mail.gmail.com>
X-Gm-Features: Ac12FXxaJSV58ZtSmvLhLfY_VJ8BQ1Q8AgfA_uaS7WvV3fFG0Z5RSbYk23fF_Y0
Message-ID: <CAMZ6Rq+FH99xRNqndUVqFQwBMjutdrYsrvpJn_n6gTOC7zsAkg@mail.gmail.com>
Subject: Re: [PATCH] can: peak_usb: fix USB CANFD devices potential malfunction
To: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed. 23 Jul. 2025 at 18:03, Stephane Grosjean
<stephane.grosjean@hms-networks.com> wrote:
>
> The latest firmware versions of USB CANFD interfaces export the EP numbers
> to be used to dialog with the device via the "type" field of a response to
> a vendor request structure, particularly when its value is greater than or
> equal to 2.
>
> This patch corrects the driver's test of this field.
>
> Signed-off-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>

I think you should add a Fixes tag so that this gets backported to stable.

The code itself is OK, so:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index aa0b68c1ae81..356f76acedd4 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -1003,10 +1003,11 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
>                         dev->can.ctrlmode |= CAN_CTRLMODE_FD_NON_ISO;
>                 }
>
> -               /* if vendor rsp is of type 2, then it contains EP numbers to
> -                * use for cmds pipes. If not, then default EP should be used.
> +               /* if vendor rsp type is greater than or equal to 2, then it
> +                * contains EP numbers to use for cmds pipes. If not, then
> +                * default EP should be used.
>                  */
> -               if (fw_info->type != cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {
> +               if (le16_to_cpu(fw_info->type) < PCAN_USBFD_TYPE_EXT) {
>                         fw_info->cmd_out_ep = PCAN_USBPRO_EP_CMDOUT;
>                         fw_info->cmd_in_ep = PCAN_USBPRO_EP_CMDIN;
>                 }
> --
> 2.43.0
>
>

