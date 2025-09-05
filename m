Return-Path: <linux-can+bounces-4488-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE89B4505D
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A7F1C84C1A
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961412F6586;
	Fri,  5 Sep 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="jkH2JhTl"
X-Original-To: linux-can@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9822F533F;
	Fri,  5 Sep 2025 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058866; cv=none; b=k+EuadLw7HymtJfWEXB4TILtzNTuM0t286OyYH+0KCntOimnZBwqRYpkTYXKJB+v0rLlbuO7LJVIZqtTwvr8F+phQIozkSA3LKHk+IZficGvVVleKFJ+ytT9KQ8noB9Cx8+ee/jR7CaaJVSzfIASSWtKpjrWbTikT4Akazf8qio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058866; c=relaxed/simple;
	bh=5n9zOkFssy2/AZSlIXFaEwVrcGNJwk6KNmav8dw9FLc=;
	h=Message-ID:Date:MIME-Version:From:Cc:Subject:To:Content-Type; b=SL72Wq1Q+Aqi23Vy0C9NypgkryEhVvVbTVM3N3UnAEYT9FzB6OGTCxt8O8iOWESbJX27pQhSHaFX9NKYrcYa2DJPGQm8RUiz95QKFDkvY027ViDiMYN3m6jSunFmBOeUTjSnEymqw9lcttmTR7MG0k5DxiG37at5FH/LRnakb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=jkH2JhTl; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [192.168.2.30] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 0689BC0488;
	Fri,  5 Sep 2025 09:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1757058327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xkWeTb8lOsbwxHBNQAiLG/GOYrFmBBfRltFTpI+7WeM=;
	b=jkH2JhTlc3PgelBVDX5sr4jT/CL6PhAkkZdJOddka0LABnij0/XsXaCjyoUYwP2oOxCc1d
	zmsfMyOORa3rkDhMHBEvuB6O3NpvP7Iz/RtXddbVPZBceefiFSELJQklV1z7XAx2Pfop4/
	l87zZcva+wNvTcX7tfeWY12F8AiXZjVm6l8JqoJ95lH3d+QJ3R9CAZOu4uMUJmZYjUnjql
	WtASpzUH2B9H0/YLmg6Sc0Rg5TXaqAupLnf4UIlGPdNgt32apBXe63tWWIbefHqcM81uUt
	7oiKJ5dEYEHFIyE7ikB+Ri7wRybfom7u/kRtFNjS84bmkKE2HsMCqz0VQbyP7Q==
Message-ID: <2a353817-f1da-4e7c-8b2c-0853779ec054@datenfreihafen.org>
Date: Fri, 5 Sep 2025 09:45:26 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Schmidt <stefan@datenfreihafen.org>
Content-Language: en-US
Cc: Jan Lubbe <jlu@pengutronix.de>, stefan.schmidt@linaro.org
Subject: Call for Participation: Embedded & IoT micro-conference at Linux
 Plumbers 2025
To: linux-arm-kernel@lists.infradead.org, linux-embedded@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
 BlueZ development <linux-bluetooth@vger.kernel.org>,
 linux-can <linux-can@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 "yocto@lists.yoctoproject.org" <yocto@lists.yoctoproject.org>,
 openembeded-devel <openembedded-devel@lists.openembedded.org>,
 boot-architecture@lists.linaro.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

We are happy to announce that the Embedded & IoT micro-conference was
again accepted for Linux Plumbers this year. Hosted in beautiful Tokyo,
Japan December 11-13.
https://lpc.events/event/19/contributions/2005/

Topics cover all things embedded and IoT. Boot time to kernel size, low
power communication, telemetry and also RTOS. Devicetree and build
system have their own MC and we can move sessions between them as needed.

As with all MC's at Plumbers we are not looking for talks, but rather
discussing current problems and working towards their solution. If your
proposal has a specific stakeholder (maintainer, developer, company)
that would be needed for a fruitful discussion, please mention it in
your submission.

The CfP is open now and will run until October 3rd. Please do not wait
until the end with your submissions as we are going to accept good
proposals even before the end, so the MC might be filled up before 
October 3rd.

Jan & Stefan

