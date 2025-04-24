Return-Path: <linux-can+bounces-3478-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F815A9B224
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 17:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59DF1B83EF4
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6631C700B;
	Thu, 24 Apr 2025 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="S3IO9tgg"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA71B4248;
	Thu, 24 Apr 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508207; cv=none; b=dpS9Dibj+amscQoeaMEXLUTp1IONZGh2gJUbydzQgtiFhNHqGCYbM2hACyq/KbATSgGEucueu1IRGgHtCJYBmYgSUyP/szEUukCqPJ7rzyl0ZKuh+fMktWJPv2OaPlv/oUMteLJIpROJ+fF7HHrfCqit82d6RYyl8Kx0ct5In8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508207; c=relaxed/simple;
	bh=FAw9AlnBxdtG82c89gFotCnpfCFj/TbIN9T1Pw77F2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dkc4sWcAupOb6YqYEDLUMWoD+4VXUq/W9UZgY2B2FPQaW8x4+rYMJI+kpco1HD4O8/0j6b4S3+sV3d7OjSzh9CRex5EUOK/sOOv4sUcdFGRZM0ebhkmuBEf+/pkmSuzGW9Acjr66kh/IThxRhG2w5vQnQiqZv0jMV96dw7lEyIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=S3IO9tgg; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 7yPzu41nKukJt7yQ3uUGUp; Thu, 24 Apr 2025 17:23:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745508202;
	bh=IYpEtzjrNosB5E8jFeCSdEXki60owaxRob+PyZfmWR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=S3IO9tgghABfhh6hV3OODQX6a3x8EmGK01x+X76XzKWAfCiWfBzpPpbaYil2qBPZK
	 FXn/pwwAWvzU/AKMPlrXz0TUa0Dioy+6wqcJpLLFNRlxVMFL0EHq/npwaHk8IuNee2
	 cyTFwfGbmF7bHAZYnvB6831neuQL03iYPuxi7fAv/e7y3CmAoquAk3sbs8HjuvSTcG
	 ONkpdqNzkIj4ZmGa3GC1UeUxBoQIeQH6BFdH5RuPuNQPIp//MzzA4dAGRsrcflgrtF
	 Ibl1OzQ2d40p35pVb8NleacZk05+8JhJPBn8vCIrHsu2X+n7wm9sfKPMZ8QCw4iHLB
	 mcXwFs41x+1Gw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 17:23:22 +0200
X-ME-IP: 124.33.176.97
Message-ID: <a5684bfe-981e-4ba3-bbea-d713b5b83160@wanadoo.fr>
Date: Fri, 25 Apr 2025 00:23:15 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: m_can: initialize spin lock on device probe
To: Marc Kleine-Budde <mkl@pengutronix.de>, Antonios Salios <antonios@mwa.re>
Cc: rcsekar@samsung.com, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, lukas@mwa.re, jan@mwa.re,
 Markus Schneider-Pargmann <msp@baylibre.com>
References: <20250424125219.47345-2-antonios@mwa.re>
 <20250424-industrious-rottweiler-of-attack-e7ef77-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250424-industrious-rottweiler-of-attack-e7ef77-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2025 at 22:11, Marc Kleine-Budde wrote:
> Hello Antonios,
> 
> On 24.04.2025 14:52:20, Antonios Salios wrote:
>> The spin lock tx_handling_spinlock in struct m_can_classdev is not being
>> initialized. This leads to bug complaints from the kernel, eg. when
                              ^^^^^^^^^^^^^^
Maybe you can briefly describe what kind of bug (NULL pointer dereference).

Also, if you have the dmesg log of the error, this is something you can add at
the end of the patch description.

You will probably get a CVE for your finding.


Yours sincerely,
Vincent Mailhol


