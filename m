Return-Path: <linux-can+bounces-5659-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC20C85E93
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 17:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5D31352975
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE610222578;
	Tue, 25 Nov 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+1aMzfw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CCA1F7098
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087235; cv=none; b=kUVoZrj55O/+uVSx0a88SyzRusMXJd8VUPTGHJwWJxJ/1I0HJskj/DkrwpHucLqLsTKOqwQKn8ZrWVLQcmjDit7x92c9enKPzdndS0ajQZUD6+86BijNG5ANY8MOj7PdZ56ss7+5A/HrUsG5eFKf3mRXzz2O7WTFcWxR2pm/HIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087235; c=relaxed/simple;
	bh=xkE4ab+89V1Vjs0MEwUi9cHQzdrqPn/Tz5/5jIH+eQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU3L7pO0OkcRsC91IMPjr3JFhWM/ww4LRLuqZe/B/hA/eeyx6ev8RmP7p4nGqonWQ2SG0O5pvkrWeMkVLSmNCkVyTvpqwXKpSZOdo20KACzg/FANtg9DQShT9LAtxFqOMozIIXFAEuuArhJtACyzXH3mESofth7gF/0xz+A5skY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+1aMzfw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso4482830b3a.3
        for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764087233; x=1764692033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkE4ab+89V1Vjs0MEwUi9cHQzdrqPn/Tz5/5jIH+eQ8=;
        b=Z+1aMzfwYU5TuuIlwZxdb56HEtZ8woPhPG5lvbXgiEeuV/7HD6mVB7sax1HsLbo1ps
         NUUXalsPj89s6+RPYU4BArTCzoT1uW5iL3KRiC7w6526LqyGfVV0luwRJSoqZnsU21jq
         VedxEKTlCrtVAVpixz+84IJNXDCF5wolSZ70IKNkj9j3bQvLYDFyeibiaxp4hkrq+3X3
         oxX6wzY/DS6ru0i97u4vlnHEjU/r78WvnwBIwou3oh/lEREp9QMGJ2DEV8K+NcYr6GcT
         YdwbNAcd2x1SlZD0mDgPzMHm2AiBsiNBy/uU6OPqukVaau7MTMOSeLt+FmQ4r9U7QjIQ
         sNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087233; x=1764692033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkE4ab+89V1Vjs0MEwUi9cHQzdrqPn/Tz5/5jIH+eQ8=;
        b=M/5XjbtKCTXabJCaE9naV7eJ81syJA3ebh5HALoTywRoa9535aSyR93OwSHa5plnnz
         wFP2+rPU59D4+6K53bXCWhWDycdOvkZKXNFNwGLcmc18wweVVJSyfCocWRwagAxZsrpr
         nqQNz2vfakzOioNM8WIIXTRrAjOFuXY9YHhWLsOnmBZt/LhzSIGlyTi3yXxUCd4yFfMH
         /FrHjg7VbO4y2xr9HEwat30bwwnemS0tH8pAzSg3KlQZb2jBGtQ8TOx2wwtjHcFWayOT
         lqD8lmUcowLj2nb4VATcVnOzpdTeM93tqq5dhlQi7hXgawowztS16cKZmu1YLjK0ZhW6
         xkPQ==
X-Gm-Message-State: AOJu0YwcoMp7Po/jYPpeg32KNKXW0oWi9oV7bYS1ifd2SnZe5r7BJooQ
	jIgv5DPyi8nOn3zz7+LfPgiH1lB4qh78qWLm0cTd+7bz247TFYnCc7ewb3B06A==
X-Gm-Gg: ASbGncsjZUxfkHHYjpIwlXoekxjjYT5lRKZbB98/AWsjotjoxz4MjhdrgM+Nc/EQPr3
	51LHLk32UmfoOT7SL1KH1QsONd3V9Fb9pDfzhaxMx39P+Q796QI/VlG1QaPjcyXGONFYlnDTQkU
	2sgx/CZT0ohWlRWUQtswnJYpdU8BTeLrNd9HOPZB/5skI5A4AUxtE6oO97ieazLKYa6mMMyDoKU
	QEj0kxrLJPdp3o7iIgAgLDkW+cuDk1j+huyUZupKHZbkVwdCH/eqQYqwrRSgcxlWOj71walQNkV
	QhKJxnzMfHzyFuUGWi5CHfLMtC8JSlv851+X2AnIci4ntIfBsJYVsgkdmH6eTEBQL3B2e7TPUQ4
	s8rPKKo+oLTm5XvDQ6Y/XHe4JftCCAJJCaPt3FHgiRtc0UlFn5uhaK2x/u9l61DbeJ/D5IIV/iN
	qR
X-Google-Smtp-Source: AGHT+IHhSq9WlVz5FtcZnQ5WSFblOEnWq7t3L9UB794ZywwZNSvkSlfat8hksNPrOzUI1X3kYdIGpQ==
X-Received: by 2002:a05:6a21:6da9:b0:34e:63bd:81b6 with SMTP id adf61e73a8af0-3637e0c5de4mr4005302637.57.1764087233340;
        Tue, 25 Nov 2025 08:13:53 -0800 (PST)
Received: from rakuram-MSI ([2409:40f4:211b:4c63:6bb1:769:aaf5:5a08])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fae9e2sm16795611a12.31.2025.11.25.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:13:53 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org
Subject: Re: [canxl v7 00/17] can: netlink: add CAN XL support
Date: Tue, 25 Nov 2025 21:43:42 +0530
Message-ID: <20251125161346.412538-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: 20251125123859.3924-1-socketcan@hartkopp.net 
References: <20251125123859.3924-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 25 Nov 2025 at 18:09, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Similarly to how CAN FD reuses the bittiming logic of Classical CAN,
> CAN XL also reuses the entirety of CAN FD features, and, on top of
> that, adds new features which are specific to CAN XL.
>
> A so-called 'mixed-mode' is intended to have (XL-tolerant) CAN FD nodes
> and CAN XL nodes on one CAN segment, where the FD-controllers can talk
> CC/FD and the XL-controllers can talk CC/FD/XL. This mixed-mode
> utilizes the known error-signalling (ES) for sending CC/FD/XL frames.
> For CAN FD and CAN XL the tranceiver delay compensation (TDC) is
> supported to use common CAN and CAN-SIG transceivers.
>
> The CANXL-only mode disables the error-signalling in the CAN XL
> controller. This mode does not allow CC/FD frames to be sent but
> additionally offers a CAN XL transceiver mode switching (TMS) to send
> CAN XL frames with up to 20Mbit/s data rate. The TMS utilizes a PWM
> configuration which is added to the netlink interface.
>
> Configured with CAN_CTRLMODE_FD and CAN_CTRLMODE_XL this leads to:
>
> FD=0 XL=0 CC-only mode         (ES=1)
> FD=1 XL=0 FD/CC mixed-mode     (ES=1)
> FD=1 XL=1 XL/FD/CC mixed-mode  (ES=1)
> FD=0 XL=1 XL-only mode         (ES=0, TMS optional)
>
> Patch #1 print defined ctrlmode strings capitalized to increase the
> readability and to be in line with the 'ip' tool (iproute2).
>
> Patch #2 is a small clean-up which makes can_calc_bittiming() use
> NL_SET_ERR_MSG() instead of netdev_err().
>
> Patch #3 adds a check in can_dev_dropped_skb() to drop CAN FD frames
> when CAN FD is turned off.
>
> Patch #4 adds CAN_CTRLMODE_RESTRICTED. Note that contrary to the other
> CAN_CTRL_MODE_XL_* that are introduced in the later patches, this
> control mode is not specific to CAN XL. The nuance is that because
> this restricted mode was only added in ISO 11898-1:2024, it is made
> mandatory for CAN XL devices but optional for other protocols. This is
> why this patch is added as a preparation before introducing the core
> CAN XL logic.
>
> Patch #5 adds all the CAN XL features which are inherited from CAN FD:
> the nominal bittiming, the data bittiming and the TDC.
>
> Patch #6 add a new CAN_CTRLMODE_XL_TMS control mode which is specific
> to CAN XL to enable the transceiver mode switching (TMS) in XL-only mode.
>
> Patch #7 adds a check in can_dev_dropped_skb() to drop CAN CC/FD frames
> when the CAN XL controller is in CAN XL-only mode. The introduced
> can_dev_in_xl_only_mode() function also determines the error-signalling
> configuration for the CAN XL controllers.
>
> Patch #8 to #11 add the PWM logic for the CAN XL TMS mode.
>
> Patch #12 to #14 add different default sample-points for standard CAN and
> CAN SIG transceivers (with TDC) and CAN XL transceivers using PWM in the
> CAN XL TMS mode.
>
> Patch #15 add a dummy_can driver for netlink testing and debugging.
>
> Patch #16 check CAN frame type (CC/FD/XL) when writing those frames to the
> CAN_RAW socket and reject them if it's not supported by the CAN interface.
>
> Patch #17 increase the resolution when printing the bitrate error and
> round-up the value to 0.01% in the case the resolution would still provide
> values which would lead to 0.00%.
>

Hi Oliver,

I tested the v7 branch and below are my observations.

Static analysis: Smatch reports no warnings.

I also executed the sequence mentioned in (1). I had one question regarding
the XL data-phase bitrate: Does the ISO specification define a minimum
bit rate for CAN XL? When I set an xbitrate of 1230, the command was accepted
without any warning or error:

./iproute2-next/ip/ip link set can0 type can bitrate 1000000 xbitrate 1230 xl on tms on fd off

This value probably doesn't make sense in practice, so would it be useful to
enforce a default or minimum bitrate in the kernel or iproute2?

I have another question regarding Documentation updates for the recent CAN XL
changes. Would updating only Documentation/networking/can.rst be sufficient,
or are there other places that should be updated?
I'd be happy to help with improving the CAN documentation if needed.

(1) https://lore.kernel.org/linux-can/20251122093602.1660-1-socketcan@hartkopp.net/T/#maab93b52afce096b03c2cefd955795d43ce810ff

Best Regards,
Rakuram

