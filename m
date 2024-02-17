Return-Path: <linux-can+bounces-298-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705DD8590C9
	for <lists+linux-can@lfdr.de>; Sat, 17 Feb 2024 17:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F71B21783
	for <lists+linux-can@lfdr.de>; Sat, 17 Feb 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9E7CF1B;
	Sat, 17 Feb 2024 16:10:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D57C0B6
	for <linux-can@vger.kernel.org>; Sat, 17 Feb 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708186258; cv=none; b=FvjBOJlkoIJbtW6jyLln2wSszOzie7ZYSY/JQHmSIl80TfMIdsuhEohwbPrfjtI6wnpDw3SJXEQ4q61j97UBYe0hHgmAC9n0o9Jwb/AdHMshrlja6ylEMZT48wZMoHiZLgfz31Z6UYmftAerinVa5eoNRclkf+aUKMnjGvPLe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708186258; c=relaxed/simple;
	bh=dtPnk/i3lhV4M4UKJ8+8U12UYw1HsQV/qySAgUzZqW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXm8KsqBVGEFvCyaqfvuRkj9Ko1tttrg5irEViI/00R7YklG8Z6Qo4aRsAxbo0z39DGj/Om7r/8Cc6LPPgptgzWtwN2I8SuGMBOn7/E6ifU2YzC294L7r2N794JAkYc8ftR2Sz9dVgwm4D1uh1DxM7x2KKKM+wlDZTPZ0IPgPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2739097a12.3
        for <linux-can@vger.kernel.org>; Sat, 17 Feb 2024 08:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708186256; x=1708791056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMNuQZ/z3/d712MP4w6IH3KhpET28qVOOrspUot7Eq4=;
        b=Isu0UZeywl8/OvPMGAf4VOyDuVi8jyXO/MMBKPrKIyBwxRztTqiq7D0DPCzN/UuLk3
         hdAfTg8KTEHgcnBoQ6XNxv4XQz/LHkuS2c7m89QhxmmACr1aO8l04YZQrOH4IX6cUoTz
         Hi14UnGVoGAH80Jl4cHXQHOIG06GWh1qoAMEgGi/O6evh6quiFB/XwJiJXU98BiFhxCH
         QNyBlGD/7lJypTj+0FvlTytHRWUxsGxeE7tsEy1GE/pif1Rnfgqx9WWGQ0HlYhRXVOsa
         08z7mNBASjZKHhINn49OA12IwcHg+0QtVtQymLx2A8WxV8jLHt3sWcr51niL/78KhIcU
         y16w==
X-Gm-Message-State: AOJu0YxoiswZ93HF6cFqXTU+BkY7uQ+VO6SfxvvV+3lYrIVqFy+RXl+y
	81U5ZgBqw8CDykVfgxJPo0JgAL8m954ThvMsg3KeG4uy8Vk6NZAgbLC1BBYsSbe96NOBRYwTzZ5
	HokgDMpnAal16481mQ2zD310Qmxc=
X-Google-Smtp-Source: AGHT+IHAONbRvOSor9cKJNhRtMEEPpIsWdAErdMBc9sT1nfhrFZQXMWv3Yh3Bt9HTpdeSR05E1tXTnfR8SDTOAlvOWQ=
X-Received: by 2002:a05:6a20:c288:b0:1a0:6dd9:ef76 with SMTP id
 bs8-20020a056a20c28800b001a06dd9ef76mr6266242pzb.56.1708186255741; Sat, 17
 Feb 2024 08:10:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216135553.97845-1-s.grosjean@peak-system.com>
In-Reply-To: <20240216135553.97845-1-s.grosjean@peak-system.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 18 Feb 2024 01:10:44 +0900
Message-ID: <CAMZ6RqLknp_R+5_UgkMS20R_usP6+c7ywtzHKnQXo4AWroMgHQ@mail.gmail.com>
Subject: Re: [PATCH v2] can: peak_usb: fix potential kernel log flooding
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri. 16 Feb. 2024, 22:57, Stephane Grosjean
<s.grosjean@peak-system.com> wrote:
>
> In rare cases of very high bus load, the firmware of the PEAK-System
> PCAN-USB Pro FD HW v4 can generate messages warning that the receive cache
> capacity is about to be exceeded. This modification prevents the driver
> from flooding the kernel log with messages and memory dumps that are far
> too verbose in such cases, by limiting their production to once for all.
>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index a1c339716776..aa0b68c1ae81 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -667,6 +667,19 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
>         return 0;
>  }
>
> +/* Handle uCAN Rx cache warning messages.
> + *
> + * Such messages SHOULD NOT occur. If they do, then this might come from
> + * massive PING host flooding that prevents PCAN-USB Pro FD HW v4 to handle
> + * CAN traffic anymore.
> + */
> +static void pcan_usb_fd_handle_rx_cache_warn(struct peak_usb_device *dev,
> +                                            struct pucan_msg *rx_msg)
                                                                 ^^^^^^

That rx_msg parameter is unused.

Do you think it is worth keeping that
pcan_usb_fd_handle_rx_cache_warn() function? Wouldn't it be easier to
directly call netdev_warn_once() from pcan_usb_fd_decode_buf()?

> +{
> +       netdev_warn_once(dev->netdev,
> +                        "Rx cache size warning! Possible loss of frames\n");
> +}
> +
>  /* handle uCAN overrun message */
>  static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
>                                       struct pucan_msg *rx_msg)
> @@ -768,6 +781,14 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
>                                 goto fail;
>                         break;
>
> +               case PUCAN_MSG_CACHE_CRITICAL:
> +                       pcan_usb_fd_handle_rx_cache_warn(dev, rx_msg);
> +
> +                       /* Rx cache warning means possible overrun cases in
> +                        * the device.
> +                        */
> +                       fallthrough;
> +
>                 case PCAN_UFD_MSG_OVERRUN:
>                         err = pcan_usb_fd_decode_overrun(usb_if, rx_msg);
>                         if (err < 0)
> --
> 2.34.1

