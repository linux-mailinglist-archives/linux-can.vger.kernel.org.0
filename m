Return-Path: <linux-can+bounces-4025-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0CAB0D4FC
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 10:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FD7560BC4
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5606A2D3EDD;
	Tue, 22 Jul 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="nolYdeTi"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A090222571;
	Tue, 22 Jul 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174269; cv=none; b=ugEET/hHwA5lsnNdHtE/Gf77172IBPLSdGIS88zsjKCnPcpLT9MuPxWS9dabpE5Db+UINKfG6BkPwikZE8a47tq6RFa9E0r1LZHKTTIg7EXdfNvTXYi7vdHkLsMcc2TbJuiDppp0A0Qn5aOYbx2SREmRqkZslVeQ2jxcc2M26AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174269; c=relaxed/simple;
	bh=Gnb5NMjsI9cancTxlFaoJOHyxjGFsm3mUzULyH+q+EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jis5vMGJI6Hlr/SG62rTkK5MXp+BsgDgcDm8jVbGJXUH1W8RvLaxdiJDiSawqSrkOYg7bsnAD3YwfJGtRH20Fg9qupbdrd8jWp3rfkAfH6Iob7kl/+AOLs7wXPMXXBm7SAyLLiSquXx1UOuqfJ2hHCHaNPiz3xZy+1L5KIVd5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=nolYdeTi; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id e8i9ufli8Q4Mme8iAupR80; Tue, 22 Jul 2025 10:51:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753174263;
	bh=5smbSKke5f39kRSBejeC2o9Nj4GKcStou/AtwBkTZnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=nolYdeTiM1/nexwunDPZkLpBOzGKiQ7aWHVXlqNm7sCAeYs+d3WihThA3maSq2af/
	 ch+GBS+lzh75S0Tc/2+Mb/mksPHtU/+kWpTnMNRR21Ae/YW84BVSDMkOQOPKGmGMRi
	 JUS3RlGKkcvnTzmgYqry7WPyutN3H9bBY/k88oidIscs0fPP1RbOT9xAaOoj2JKB1d
	 qbJOxZ9yi58/oIjsaTAXLaDuD+9kHgi9BEIt0PDFmxgUFxI0qUXu6xtsgJSQmtb/++
	 pZADEqhyTQbJeDLNMWLwLkrO6rPaHP0H+uQbxdC2LVhMCXqDZwLdc4e7Cyjg4LxtD+
	 0dqQ55TbhTr+w==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 22 Jul 2025 10:51:03 +0200
X-ME-IP: 124.33.176.97
Message-ID: <83498a43-9e39-44ae-821d-7a7492f57a83@wanadoo.fr>
Date: Tue, 22 Jul 2025 17:50:56 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: Fix kernel-doc error in CAN driver
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, Ondrej Ille <ondrej.ille@gmail.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250722035352.21807-1-luis.hernandez093@gmail.com>
 <202507220837.23333.pisa@fel.cvut.cz>
 <399941c7-2ee5-4d8b-a7c6-c8ed7d85b565@wanadoo.fr>
 <202507220957.14122.pisa@fel.cvut.cz>
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
In-Reply-To: <202507220957.14122.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2025 at 16:57, Pavel Pisa wrote:
> On Tuesday 22 of July 2025 09:27:39 Vincent Mailhol wrote:
>> On 22/07/2025 at 15:37, Pavel Pisa wrote:
>>> On Tuesday 22 of July 2025 06:06:30 Vincent Mailhol wrote:
>>>> On 22/07/2025 at 12:53, Luis Felipe Hernandez wrote:
>>>>> Fix kernel-doc formatting issue causing unexpected indentation error
>>>>> in ctucanfd driver documentation build. Convert main return values
>>>>> to bullet list format while preserving numbered sub-list in order to
>>>>> correct indentation error and visual structure in rendered html.
>>>>>
>>>>> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
>>>>
>>>> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>
>>> Reviewed-by: Vincent Mailhol <pisa@fel.cvut.cz>
>>
>>                ^^^^^^^^^^^^^^^
>> Are you trying to impersonate me?
>>
>> Can you reply again with the proper Reviewed-by tag? ;)
>>
>>
>> Yours sincerely,
>> Vincent Mailhol
> 
> Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
> 
> Excuse, I have been in too much hurry.

No problem :)

Marc, b4 will not be able to manage the review tags correctly. Can you please
fix it manually when picking up the patch?


Yours sincerely,
Vincent Mailhol


