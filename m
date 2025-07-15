Return-Path: <linux-can+bounces-3994-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4096AB05840
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 13:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659C417E881
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088651F0E47;
	Tue, 15 Jul 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OfR2cNv7"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8B1D5ABA
	for <linux-can@vger.kernel.org>; Tue, 15 Jul 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577190; cv=none; b=QWJKjpYM9dHrqXtUYgWKn7C/iv5dZEPDUvmXxMTGSvSFhhypXUo9WeM+VmwQRkWhcwjM3K0El3MKBP7J8SXUm2IAObKCa2H7xUlc+o+LD1fuvJRAbgz03BlRaOJrZk85xs7/CRDt+s4B6f2nd5xW3KuYhakn9AVNbkIEbp30BH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577190; c=relaxed/simple;
	bh=oVoJADOOiA13M2ohLe40YpBChaWHBpPYGjic8PtFjmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgcmLjh/mWt9s/1kO2Z7+xte+NvJ4X5uhQrhqgwfPEZ6vvohZ5judTJzKh8BMDyi2yK2PhjteRjCCMMcNOiHMNc+sIL51KF3IyoKr5o0dXLUG+XC59PkksrW2UUd5lqtzBXYed+Cq+Up7K6h4NbamJHFfjDjgu/TGO4TP/aqc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OfR2cNv7; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id bdMguF3eG03JcbdMouvpRG; Tue, 15 Jul 2025 12:58:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752577116;
	bh=1jhDd6dc0+beRQcPRk7Oc7X4pE0LcNfWedEkFS4RZdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OfR2cNv7Ckk/z+3eRY+MUl+ebgNuMGHLIPhvBw0eKuqoa6sV/q14I9AzRFnc2GG1C
	 tNjbQdk6IXEWnRoyAiuuz5SEm/B22tBB608hUQ8n5CYYat31YiWJ4+qtEnpQbPIbHF
	 +92k8VUV+V0lZF6nZaFoByaIcccATuZohzKzxHLxqDS9GR9tYx2v4N1ECuXumT3sYg
	 CqmmRG2HoQExntN2BL8G4jfM6wRJZ7Pf5e5rYaDMXel/0/yc2scuf8vSsBkKpzTXzw
	 GLHGCiLJXkoxJMcSPLXCO8aTDm/SJTpOseT+w1Fb5kH944xlJH4NgVjQIOnfC/aGL9
	 dY7vQBZezcc7A==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 15 Jul 2025 12:58:36 +0200
X-ME-IP: 124.33.176.97
Message-ID: <11f81602-4eee-4c11-ae24-4bc5951dad91@wanadoo.fr>
Date: Tue, 15 Jul 2025 19:58:25 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next/b4 2/2] dummyxl: print ctrlmode and PWM values
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20250706133550.47369-1-socketcan@hartkopp.net>
 <20250706133550.47369-2-socketcan@hartkopp.net>
 <CAMZ6RqJaYY_ZDOo-V_+4mDPZvp0WU4K=iWL44sd0_hYhMLOP_A@mail.gmail.com>
 <20250715-futuristic-tricky-raptor-9f9195-mkl@pengutronix.de>
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
In-Reply-To: <20250715-futuristic-tricky-raptor-9f9195-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2025 at 19:06, Marc Kleine-Budde wrote:
> On 14.07.2025 02:25:01, Vincent Mailhol wrote:
>> On Sun. 6 juil. 2025 at 22:36, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

(...)

>> I rewrote it as below:
>>
>>   static void dummyxl_print_ctrlmode(struct net_device *dev)
>>   {
>>           static const char *names[] = {
>>                   [ilog2(CAN_CTRLMODE_LOOPBACK)] = "loopback",
>>                   [ilog2(CAN_CTRLMODE_LISTENONLY)] = "listen-only",
>>                   [ilog2(CAN_CTRLMODE_3_SAMPLES)] = "triple-sampling",
>>                   [ilog2(CAN_CTRLMODE_ONE_SHOT)] = "one-shot",
>>                   [ilog2(CAN_CTRLMODE_BERR_REPORTING)] = "berr-reporting",
>>                   [ilog2(CAN_CTRLMODE_FD)] = "fd",
>>                   [ilog2(CAN_CTRLMODE_PRESUME_ACK)] = "presume-ack",
>>                   [ilog2(CAN_CTRLMODE_FD_NON_ISO)] = "fd-non-iso",
>>                   [ilog2(CAN_CTRLMODE_CC_LEN8_DLC)] = "cc-len8-dlc",
>>                   [ilog2(CAN_CTRLMODE_TDC_AUTO)] = "fd-tdc-auto",
>>                   [ilog2(CAN_CTRLMODE_TDC_MANUAL)] = "fd-tdc-manual",
>>                   [ilog2(CAN_CTRLMODE_XL)] = "xl",
>>                   [ilog2(CAN_CTRLMODE_XL_TDC_AUTO)] = "xl-tdc-auto",
>>                   [ilog2(CAN_CTRLMODE_XL_TDC_MANUAL)] = "xl-tdc-manual",
>>                   [ilog2(CAN_CTRLMODE_XL_RRS)] = "xl-rrs",
>>                   [ilog2(CAN_CTRLMODE_XL_TRX)] = "xl-trx",
>>                   [ilog2(CAN_CTRLMODE_XL_ERR_SIGNAL)] = "xl-err-signal",
>>                   [ilog2(CAN_CTRLMODE_XL_PWM)] = "pmw",
>>           };
> 
> Is the compiler clever enough, or do you have to use const_ilog2()?

Yes, the code above compiles and runs without issue. ilog2() expands into
const_ilog2() if its argument is an integer constant expression (which is the
case here).

Also, note that the [ilog2(CAN_CTRLMODE_XXXXX)] thing is optional. Doing:

  static const char *names[] = {
  	"loopback",
  	"listen-only",
  	"triple-sampling",
  	"one-shot",
  	"berr-reporting",
  	"fd",
  	"presume-ack",
  	"fd-non-iso",
  	"cc-len8-dlc",
  	"fd-tdc-auto",
  	"fd-tdc-manual",
  	"xl",
  	"xl-tdc-auto",
  	"xl-tdc-manual",
  	"xl-rrs",
  	"xl-trx",
  	"xl-err-signal",
  	"pmw",
  };

also works. But the above is more prone to silly mistakes. The ilog2() trick
prevents any index mismatch.


Yours sincerely,
Vincent Mailhol

