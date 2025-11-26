Return-Path: <linux-can+bounces-5746-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EECC8B74D
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 19:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD51D3A3A67
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA731195F;
	Wed, 26 Nov 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9Z1dGAx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E4278E53
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764182276; cv=none; b=k0Ta6tAvgyQ6L2wH2/PlE0ZrZxxWnLLhXOmKx4kYrfPcdguQSOjiquitI8Y0A2brHs4jH4R5ntvsEJWm3shxpcSUg6GYYtoan5wbbCSBMB8j1ixPALuZBF+hBOUKBC+st+XCw08x0cP7sXppngSolGWwmCw2NiDabZrDw+hXqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764182276; c=relaxed/simple;
	bh=DkE1IcadoKYdNkHpn1byLsEwljs0Hc2OL1xoDxI7TyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd6pFJt8ORb5BIRxInCCh+JHEkhj4aFKluaFl0hgo7u5bGFGIL9oM9WtXiNMv9GkQU5/uS6BFQrrnCt3nviKxmV/j94NnpJigOHi4+3imycqAaVVzdXvud/F3j8v2OJnMO5jouh+g8OG2G1FhK0A4Wy5R2X0z+1OVGq+tx+422M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9Z1dGAx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so21034b3a.2
        for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764182274; x=1764787074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkE1IcadoKYdNkHpn1byLsEwljs0Hc2OL1xoDxI7TyY=;
        b=Q9Z1dGAxRDL3R73ZEpxrfZWAOQ5h1mx5vAxSMyR9HewJyRtnsRyJLEmG4jj37XGOSq
         K/PJRVYTDqshcOTdI2VMntkz5Kp15EGfDIH1IVNXWtAR7sq+7+/yN5Yb6FyFTISWofX4
         AWSUQEnccYaVmJb+3eQ0Dse59pK73ztaUKKl99o576EscS78Tgk2vFgIAxQHcAT0v9iZ
         ep6p5UWPDaVKdcxe+yTIOMdbsXYe+AM/Loh2HjSkBXVDTiy851Hn5+UTswr0QDSE00QC
         5sFGd3Ut3rR9jRMssG3Egy00QQE0rrOO4vxbDsFzjh49PiOrxNVnyvtnSby7+zisNbJW
         me0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764182274; x=1764787074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkE1IcadoKYdNkHpn1byLsEwljs0Hc2OL1xoDxI7TyY=;
        b=guRFViS4fARjh9gq6iyXNjdQzMkdvh6At9+K/KgS/v3tb2BobUKoCn6sy+LSRJ13VN
         zZnAFoqYeNopqm5RtnqVIslv/VivuFBT6f67DPMkRIs3TtQkWCNbyo6pFnjGpdyFhAsT
         4xFD8HoD2hV+D2PTqYDaj5qJWb6qe+EcoD0Xgwn/uPyxWZ10WHiRdzPUfSek6m7S4kWj
         KPHRrzwqN+qeHesqJAajqZ0nD1Jcv/q78Sd0fxcKH0NFrNlHZaf0Lupy168wvYMkEZ1y
         WVdiR1AfSUkWwSBax5FaaozhyaZY5knI4zV5SvUkdIPudAcmJqhWEMatmqCh0EO5yYfQ
         zncg==
X-Gm-Message-State: AOJu0YzjkxaUKFhjvMlHZu0dopklaQTciDP+E5qwZOWTcN8ZvmdckTbB
	FK8iMpsmxg5H7NI2DlGCK8C25EZOFR17uYt8dRoAYf7k1YhNHFlKuYWA
X-Gm-Gg: ASbGnctoMnZNKwF4KwaSpMzuxw4GTb2ndIAbCzCIB9N7tLDKQwDta/423NzOXYmyAGL
	N2AS33NAkEx77rDI9fVluvxCCY2+UDYDG0EH+ZV8X9iNeq2NOTDuQaEQ5QchsyeP3ATNUtyC+za
	NCU+f1YaE2ylmLI3aoIU0VYzzeORXhZI7rvOTFML6PX6X9IY9OQ8C+/gpK4THvrNIEmpl2BzDST
	+1vl43YT+z4Mt0OyLhlF+d1uBnrtnIGnB9l1hvud0BAXaKu1ZUHa7GGpdyTracqKKC7JHUdTEkE
	WOWsXaN94BoFSAVffUS+N4yqZ6hpIx7MGUIw0Gl668SFkVhgIqAxojKeSG91xzZlfxGPJ2yUfZB
	OxKhvIdQglooJ20s1yqflidAIFuwORDJKXiOxaD+i7eWt7k9X2zufL4UAJUUE0QRNJeDen/PydI
	bt3Jjolw949H1FAGQ=
X-Google-Smtp-Source: AGHT+IGgN8MrNHCYELyDYRKdLUH2tR2SVecbKNvP9vKLDM7UpJo6DhObvcJzLYv91ZGIz0n0AHnYpw==
X-Received: by 2002:a05:6a21:3296:b0:35f:7431:5d98 with SMTP id adf61e73a8af0-3614eb77b74mr22085131637.15.1764182274490;
        Wed, 26 Nov 2025 10:37:54 -0800 (PST)
Received: from rakuram-MSI ([2409:40f4:2109:7588:699:9313:4f5c:82f9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e4c9ff5sm19677025a12.9.2025.11.26.10.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:37:54 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org,
	rakuram.e96@gmail.com
Subject: Re: [canxl v7 00/17] can: netlink: add CAN XL support
Date: Thu, 27 Nov 2025 00:07:45 +0530
Message-ID: <20251126183749.43312-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: c6b03bd3-572d-463f-a21c-55e413128b00@hartkopp.net
References: <c6b03bd3-572d-463f-a21c-55e413128b00@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 25 Nov 2025 at 22:29, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi Rakuram,
>
> On 25.11.25 17:13, Rakuram Eswaran wrote:
>
> > I tested the v7 branch and below are my observations.
> >
> > Static analysis: Smatch reports no warnings.
>
> Excellent!
>
> > I also executed the sequence mentioned in (1). I had one question regarding
> > the XL data-phase bitrate: Does the ISO specification define a minimum
> > bit rate for CAN XL? When I set an xbitrate of 1230, the command was accepted
> > without any warning or error:
> >
> > ./iproute2-next/ip/ip link set can0 type can bitrate 1000000 xbitrate 1230 xl on tms on fd off
> >
> > This value probably doesn't make sense in practice, so would it be useful to
> > enforce a default or minimum bitrate in the kernel or iproute2?
>
> I double-checked with some tools from Vector and PEAK. And although it
> doesn't make much sense was there no constrain that such a configuration
> is forbidden. The CAN XL controllers with their 160MHz clock and their
> very capable baud rate prescaler are able to deliver even such weird
> bitrates.
>
> Therefore we better do what the user configures.
>
> Or do you have a reference why this should not be allowed?
>

Understood. At the moment, I don’t have any reference that would indicate
such a configuration should be disallowed.

> > I have another question regarding Documentation updates for the recent CAN XL
> > changes. Would updating only Documentation/networking/can.rst be sufficient,
> > or are there other places that should be updated?
> > I'd be happy to help with improving the CAN documentation if needed.
>
> AFAIK there is currently no updated documentation for can.rst in progress.
>
> Feel free to contribute some patches for can.rst
>

Thanks. I will prepare a patch for can.rst and mark it as RFP to collect
feedback on the proposed improvements. Based on suggestions from the community,
I can refine the documentation further.

Best Regards,
Rakuram

