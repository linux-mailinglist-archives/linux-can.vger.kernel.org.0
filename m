Return-Path: <linux-can+bounces-5469-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD0C65951
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 152FB3A021A
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188A22E8B62;
	Mon, 17 Nov 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KePt7xJj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595E23D7FD
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400636; cv=none; b=p0lyAdN3HxYg9SHzx8rFjbeGtRlHO7p9m0AiMDRl84txfIV2DmSd8bA3YyvK3uJRakhWxDfHNc/8VzFSo/tssM4sHhjm6G7F1yA0XvjyFdI6MIPEg3pIEwFQ1I5LzhMRlthIqZNiqlI5clTNQysrVMIVMVzA6qjx8g9sonHmE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400636; c=relaxed/simple;
	bh=w4CIjNZ1605si4lfku8gD0WaSIuSJ0mIYmzzxkOiGMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CN04Bg+jVBkuvOilDrDLKMVEIMdR/jfoTstHHkyIn+/swSu5NJbGXUWBucON2ndl5oYyMcQPW/YU81r+4mBOseLVDSmJNvK0yZdKMJynuQLNrYtERzE2JzYDRPczcTX4fgKzOaDsOfa/0pi4c49zY2Iun5KXTWEUMFeL3TBIRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KePt7xJj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ba92341f83so372287b3a.0
        for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763400634; x=1764005434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLRfQs0wWjDMt4ZR8Ou2KlvzNHuxRbwkp7eOWLdaSCA=;
        b=KePt7xJjOgrGGydsaJZemyFPoB29kOA3vkkHZio4rOw6VUmc66M6RIBh1FeGGcou3q
         QRruayVCBJwfEcKbIVsEzCNCfNOBfdH9CzZlqulGe0Z3WWAmcDjSpuQ5Ud1BD+rpWTrt
         KnK4dwanHtnF4sYUzWC3jTy4sdI7LKZF1pdPdPFlZ+0rJlhjI8gBl9rLp617ukDyZQ0V
         Jqk9JTFRs6H0XqJ7tSNxNnTbEaPzDaCKQ5VVRaH3SotF68EHwmjYJIFDsKLXO2Xm4GQH
         xsnt6W+8zbT6kkJM3sS4W8VRAL/6VlbEBryJ+T0qiJA+eZ+mrywk4Er2no2yVk5xZZIT
         Lg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763400634; x=1764005434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLRfQs0wWjDMt4ZR8Ou2KlvzNHuxRbwkp7eOWLdaSCA=;
        b=WlST/mLnddIP75zMsYMH9VHAxMNfVKDWHRnXw+2YsvBgx6wS1Z86F2tY9GIgepPY8Z
         HuzV95lcRQHG+ecSeYrvdZjwO2TZ5iSKYdJtuRBGPky8iEdPerkzFghAe6UIrNmu2LpI
         tkHtk8WNfCqxPXQG1D+Coh5DD0l+/kmJYQuaUODVmmM4claXNjCMKz3Rympvu1FcA56d
         lvWNEHmi4vJjz7NRZWArBPUp0zf22BH7pCm/ST6tfqb+VetjwgkIkechk0WpA+MsP10I
         BfSqg2eE4jURxi43CB3lL08zsSjEpPKvEQT9x6+p1WqWSO5ND8FfK8/XvkYDGmbXnD/2
         ncfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg5hM0+xWI/uO8WgtPZCsYJtxTZgYTAR0+DHvXeYzDDXPuALL7Jbka/VlSa0AE6nyCCxsPjRNeCBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnj70vCxRzghmcT8vE60M8MVsC/PDEAC/t8b1LMJl7o0oN0V9a
	t0dVodthWfQNZkOtup0Ni5x36NFPlOlMTv9R7vo/wwjc2Ox3Dkw+ksGu
X-Gm-Gg: ASbGncty1IkBpkahM50yQ1j6P3b8Zn1JUKz4zRC+AehlxUQaURvGRcnwnubfCrh11OF
	geqtcYAiGJj4gwXWAEYLDJZHAl2O7vsaubmY/IJPg9alnKKKsCmwOZv93EoEhu/xL/WsXLdW/U8
	kVWy4wuWMDHUa8tSVh7kOtTUlVzNAvD0zz5v997EGNkzkNfpae6aQV7DWEAmGsLBup2YNe/s06k
	v1mh8Xlle7idLHfToLvYmCwIqV6XNRk+mhTuxjpKSOFlOxu5otqsi2dk0yMWj1lP6G4DQasf3Fz
	BEG3xrjZlHTRS81zNSfx0eWCZwO3bTHDIg9lwZtfyAHppWncFhWiT52gEZljhZU5akfvK8bEEg9
	uUOw3T7zK2Dv2ddOZk2eM1TN5InZwgkBFW2nf+9VFrK5cl/FITRanKpW6xotd3nWBsqGaebbS9K
	u3Al6DbFk3DDadRR2uh5K4rnKLago=
X-Google-Smtp-Source: AGHT+IHxcHbYLyxGHkkMTrm/9p2ZR9u/2hNozbN4KKPL2qiL7l+8pQd/jgrPZ0GUj6AXL5V5qcqAgA==
X-Received: by 2002:a05:6a00:4fcf:b0:7b9:d7c2:fdf6 with SMTP id d2e1a72fcca58-7ba3b89ed15mr17413944b3a.24.1763400633752;
        Mon, 17 Nov 2025 09:30:33 -0800 (PST)
Received: from localhost.localdomain ([114.79.136.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9251c99aasm13948208b3a.28.2025.11.17.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:30:33 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: mkl@pengutronix.de,
	socketcan@hartkopp.net
Cc: Prithvi Tambewagh <activprithvi@gmail.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: Question about to KMSAN: uninit-value in can_receive
Date: Mon, 17 Nov 2025 23:00:12 +0530
Message-Id: <20251117173012.230731-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <68bae75b.050a0220.192772.0190.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The call trace suggests that the bug appears to be due to effect of change
in headroom by pskb_header_expand(). The new headroom remains uninitialized 
and when can_receive tries accessing can_skb_prv(skb)->skbcnt, indirectly 
skb->head is accessed which causes KMSAN uninitialized value read bug.

To fix this bug, I think we can call can_dropped_invalid_skb() in can_rcv() 
just before calling can_receive(). Further, we can add a condition for these 
sk_buff with uninitialized headroom to initialize the skb, the way it had 
been done in the patch for an earlier packet injection case in a similar 
KMSAN bug:
https://lore.kernel.org/linux-can/20191207183418.28868-1-socketcan@hartkopp.net/

However, I am not getting on what basis can I filter the sk_buff so that 
only those with an uninitialized headroom will be initialized via this path. 
Is this the correct approach?

Thank you,
Prithvi

