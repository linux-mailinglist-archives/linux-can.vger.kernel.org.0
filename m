Return-Path: <linux-can+bounces-2529-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A527A002C2
	for <lists+linux-can@lfdr.de>; Fri,  3 Jan 2025 03:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E9E1883D15
	for <lists+linux-can@lfdr.de>; Fri,  3 Jan 2025 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599B02AD20;
	Fri,  3 Jan 2025 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UhuN/QDK"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE64C62
	for <linux-can@vger.kernel.org>; Fri,  3 Jan 2025 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735871629; cv=none; b=SqAxoVA/BS1Q7JagXJ+YrJLmoSqRe5s/Iti9aOT8kXUlcRC53gLsDAD9wiD822t2kamSNWDEokFY1DMUbwH4wbMTZXGjCRvFDoDkE7Db4db7zygnvGLSXZTR7x7vYHEpha6Xe2IrmNZLOpG9GgqRl46uuxplKYr7RM8TEqJW66A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735871629; c=relaxed/simple;
	bh=9+T5EPcTLjM5aHcnSYZVc7UBRH9SAvE6yht2eFcyin0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNWapCKGN+7oEA5nOFsqOTcBJMhOC+YKwq8sITR6BmOSL5wQMyrKMGMhWUCFw8yvVCwtYpUn5BRB6U0N1SP7ca0z/6DQn153nEXhSgd8lq4FDOuR6THsqKeqpINxtDjsB5sVZiyn0W5dLOUL0BmHyLPs4YEuimnIXaGTiWot4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UhuN/QDK; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id TXVDt9pyMoTrQTXVHtOemJ; Fri, 03 Jan 2025 03:33:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735871618;
	bh=aXoGRSr8hcUJqjfeqZJqDEu0NkjR1GPcyM7wR2V4pc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=UhuN/QDK4MyTVLjHMOnQFbSVUtEOTUUaz8DhyIlhLoGsij+bJ50mcKy587GqLyI/6
	 jKaOXIKu9yWmadivT9f4x/3hwz94s62eUabkc8bFDzLQLXcOqzaJJL0ShiydbY1aHt
	 X0ISnla+qMYe/GOOrKexliXFyY8BfvVsNdywOu1dzlE0aOhajdJkuT282nk3/XmqtV
	 NP0gC/7KD0VL1cK+bFGP4p76laDdHSpB8dtM+EfMzBEoinGF50D6IvShZjooJ5ByBZ
	 UCgJgTyULwr2uU17FA5F0sxCusk6yT0mW51cpaF79+7Cya4VNFEmd8u7PCpR0H+eq3
	 e3GODjU8W5ZXQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 03 Jan 2025 03:33:38 +0100
X-ME-IP: 124.33.176.97
Message-ID: <58837571-9bb0-47b3-be0a-fd3eb5ff1273@wanadoo.fr>
Date: Fri, 3 Jan 2025 11:33:30 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] can: esd: add CAN-FD for esd GmbH PCIe/402 CAN
 interface family
To: =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 Robert Nawrath <mbro1689@gmail.com>
References: <20250102185821.670839-1-stefan.maetje@esd.eu>
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
In-Reply-To: <20250102185821.670839-1-stefan.maetje@esd.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/01/2025 at 03:58, Stefan Mätje wrote:
> This patch adds support for CAN-FD in the existing esd_402_pci
> driver for the PCI based PCIe/402 CAN interface family from
> esd GmbH.
> 
> The patch is sent as RFC because the driver needs some
> extensions in the netlink interface and user API.
> 
> @Vincent: I see that it conflicts with your changes for
>    CAN-XL support in netlink.h but I send it as RFC
>    to show what I have now.

No problem. Whoever is merged in second will rebase, shouldn't be hard
though :)

> The esdACC CAN controller has only a single bitrate prescaler
> for both the nominal and data bitrate. The hardware was
> designed this way to follow CiA recommendations for the
> bitrate configuration.
> 
> The detailed recommendations of the CiA can be found here:
> https://www.can-cia.org/fileadmin/cia/documents/publications/cnlm/march_2018/18-1_p28_recommendation_for_the_canfd_bit-timing_holger_zeltwanger_cia.pdf
>> The current bit rate calculation in the kernel is done independently
> for the nominal and the data bitrate. This can lead to the fact
> that the selected nominal (NBRP) and data bitrate prescalers (DBRP)
> differ. This kind of configuration is not supported by the esdACC.
> 
> In a first step to avoid this I propose to add a new control mode
> CAN_CTRLMODE_FD_COMMON_BRP that tells the bitrate check logic
> to reject bitrate settings with different NBRP and DBRP values.

Do you think that we may have controllers with shared Classical CAN and
CAN FD BRP but different CAN XL BRP? If not, I would suggest to make
this "CAN XL ready" by using a CAN FD agnostic naming, e.g.
CAN_CTRLMODE_COMMON_BRP or CAN_CTRLMODE_SHARED_BRP.

> This CAN_CTRLMODE_FD_COMMON_BRP is set statically by the driver
> to tell that it needs a common BRP (see patch 0005).
> 
> The netlink part of this is done in the patches marked with
> "DO NOT MERGE" in this patchset. 
> 
> In a second step the bitrate calculation should be changed to
> prefer to use a common BRP at least if CAN_CTRLMODE_FD_COMMON_BRP
> is set. This could be based on the bitrate calculation
> algorithm of my colleague Oliver Thimm that I will present
> in a follow up email. This email will then also discuss the
> advantages of this approach in more detail.
> 
> Unfortunately I have no patches yet.
> 
> I will send a patch set for the iproute2 tool to add the
> capability to set the CAN_CTRLMODE_FD_COMMON_BRP using
> "fd-common-brp" with the ip command.

Looking at the paper you linked, I understand that it is recommended to
use a single BRP. But this raises a follow-up question: is there any use
case in which we do *not* want a common BRP? If such use case does not
exist, then I am not convinced that the CAN_CTRLMODE_FD_COMMON_BRP
should be exposed in the netlink interface.

If common BRP is simply better, wouldn't it be then simpler to just
change the bitrate calculation so that everyone uses common BRP?

That said, maybe there is one edge case I am not aware of. If under some
circumstances it is not possible achieve common BRP, then that new
control mode makes sense. And I guess that if the calculation fails to
select a common BRP, then this control mode will be used in the new
algorithm to decide if the calculation should stop (shared BRP) or
continue (different BRP allowed).


Yours sincerely,
Vincent Mailhol


