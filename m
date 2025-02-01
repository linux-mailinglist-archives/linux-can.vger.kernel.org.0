Return-Path: <linux-can+bounces-2711-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C1A24B78
	for <lists+linux-can@lfdr.de>; Sat,  1 Feb 2025 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5256B7A2C49
	for <lists+linux-can@lfdr.de>; Sat,  1 Feb 2025 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9E1BD01D;
	Sat,  1 Feb 2025 18:53:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814331CAA8D;
	Sat,  1 Feb 2025 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738435985; cv=none; b=dnKGyiy4ddT1+h5htZcsHUH6AzaackKz72Gweh2lHdksD/sMp/gtFHMEwa7Qh6WJ/R79/fJP5zToPLb+43VXwjvTYiciNzECRMNgJaBefUrmahhdVRGvHrMKIUpWYJuoaSmSTLZ0XtX4KeQabHD0Jltk8/DEzIM7nu+GNudi+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738435985; c=relaxed/simple;
	bh=IWZP2FeroAYCmDrqHIdLqsLMHsO6gkmcHX08RRKaDPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dmm8ImCUmHAeJ6/AYcFyeZfcTlgQckUHjfMLHxmHY+cGgyUwPAto9T9SS0xiuJ1H+4km+7wOxTbmHe1aejUhlqGsnILlUvpC9GUPF/D49PLKFGiS7bL9q6RtGycXpX05K2848y/j1cyGzoRmyK7rzu5g+nQrak5ywThQeXUx45I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.152.188) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 1 Feb
 2025 21:52:44 +0300
Message-ID: <2cdfed6a-4461-4c57-96b8-a6c928f2f0ac@omp.ru>
Date: Sat, 1 Feb 2025 21:52:43 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: rcar_canfd: Use of_get_available_child_by_name()
To: Biju Das <biju.das.jz@bp.renesas.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>, <linux-can@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das
	<biju.das.au@gmail.com>, <linux-renesas-soc@vger.kernel.org>
References: <20250201094642.16243-1-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20250201094642.16243-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 02/01/2025 18:42:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 190726 [Feb 01 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.7
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 50 0.3.50
 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.152.188
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/01/2025 18:45:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/1/2025 5:25:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/1/25 12:46 PM, Biju Das wrote:

> Simplify rcar_canfd_probe() using of_get_available_child_by_name().
> 
> Simplify rcar_canfd_probe() using of_get_available_child_by_name().

   Twice? :-)

> While at it, move of_node_put(child) inside the if block to avoid
> additional check if of_child is NULL.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[...]

MBR, Sergey


