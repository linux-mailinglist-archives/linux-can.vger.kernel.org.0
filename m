Return-Path: <linux-can+bounces-405-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A8F87EDC7
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 17:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238551C20EBD
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5B54BC5;
	Mon, 18 Mar 2024 16:45:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail601b.mxthunder.net (mail601b.mxthunder.net [209.41.68.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4554BC4
	for <linux-can@vger.kernel.org>; Mon, 18 Mar 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.41.68.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780329; cv=none; b=UES+FJssqbfCly5mFBsqg7ZK6+ZP7pR5ZcfEafpZr+wjDOl9lI/89EJMeb7pddQGWX7eF5/LJ8DqVWYnzs9kalEb+emKyqi0lWTaf1ijTVDVC7JH6hD2qYEMbuJpFsAgKgO9PuLZxTu5FAMItS52IvG3c2C70r2UXiKeTc5xW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780329; c=relaxed/simple;
	bh=zCl4YM4xkFLAYPEj/iGfr2LgiwN0Ouiy9LGVUbG8b9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n670yCDGWLOINN1qd8OFKL7oF+lOnv+PGTKWtSGWwleSVzWg36GVp++4cpSrqpXKrztwT6u3QwBS0mbtF/fzmchRFTOuL2WvLpuvwKNimTHHQwqfluoz4eOIAADq61FmAG3vB4wYT/G5aHgtkwf50fG0tYP2hd2Mvkfvuw3olyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wireshark.org; spf=pass smtp.mailfrom=wireshark.org; arc=none smtp.client-ip=209.41.68.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wireshark.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wireshark.org
Received: from bolt101b.mxthunder.net (bolt101b.mxthunder.net [209.41.68.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail601b.mxthunder.net (Postfix) with ESMTPS id 4Tz0rY3J5SzGTFsD;
	Mon, 18 Mar 2024 09:37:33 -0700 (PDT)
X-MXT-TRACKING-KEY: 4Tz0rY0YDyz96NgW-101b
Message-ID: <09952070-5182-4d63-bb2b-0cf6cfe2053d@wireshark.org>
Date: Mon, 18 Mar 2024 09:37:32 -0700
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Wireshark-dev] [PATCH 0/4] Wireshark SocketCAN updates
Content-Language: en-US
To: Developer support list for Wireshark <wireshark-dev@wireshark.org>,
 Guy Harris <gharris@sonic.net>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20240318104643.24098-1-socketcan@hartkopp.net>
From: Gerald Combs <gerald@wireshark.org>
Autocrypt: addr=gerald@wireshark.org; keydata=
 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
Organization: Wireshark Foundation
In-Reply-To: <20240318104643.24098-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MXT-EXTENDED-ID: 4Tz0rY0YDyz96NgW-101b-72694-A-yyIEQq-500b

Thanks for your contribution! Can you submit a merge request at

https://gitlab.com/wireshark/wireshark/ ?

Complete documentation on contributing code to Wireshark can be found in our Developer's Guide at

https://www.wireshark.org/docs/wsdg_html/#ChSrcContribute

On 3/18/24 3:46 AM, Oliver Hartkopp via Wireshark-dev wrote:
> This patchset simplifies the CAN packet type detection as it focusses
> on the rules to distiguish the different CAN CC/FD/XL frames from the
> Linux kernel API.
> 
> Additionally some more content is shown in the dissector and the
> CAN CiA 611-1 definitions have been cleaned up and extended by CiA.
> 
> Oliver Hartkopp (4):
>    socketcan: simplify CAN packet type detection
>    socketcan: display CANFD_FDF and CANXL_XLF flag content
>    socketcan: display len8dlc content for Classical CAN
>    socketcan: update CAN CiA 611-1 definitions
> 
>   epan/dissectors/packet-socketcan.c | 86 ++++++++++--------------------
>   epan/dissectors/packet-socketcan.h | 17 +++---
>   2 files changed, 39 insertions(+), 64 deletions(-)
> 


