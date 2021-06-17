Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1913AAD37
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFQHUY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 03:20:24 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:38274 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFQHUY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 03:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623914293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0phvptjMwOdLxHc6uH2So5bqysJlj8nAt92UycKxek=;
        b=r+IReweA/DM/rK8eyCjwB9lRhzBAXjAt2s1Gf12Ry+xPJH9Jrafal2pPl/PCwW1wCx5occ
        0r5yUgxA5y+1/d+bTbLzxB/22+NmiT488HMok1JTwhOhGIDhgQ494Lnd9UBymxqRGD6Bx6
        oc/pElK2Q5bDjbJiROwrX1o/1v/F6HY=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 5b26ddc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Jun 2021 07:18:13 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] m68k: m5441x: add flexcan support
To:     Greg Ungerer <gerg@linux-m68k.org>, wg@grandegger.com,
        mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <20210616231652.738027-3-angelo@kernel-space.org>
 <45495fee-b026-0a2c-6b98-1631cbd8060f@linux-m68k.org>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <bbe98567-a767-8eb3-9258-b6a66bc7a476@kernel-space.org>
Date:   Thu, 17 Jun 2021 09:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <45495fee-b026-0a2c-6b98-1631cbd8060f@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Greg,

On 17/06/21 2:18 AM, Greg Ungerer wrote:
> Hi Angelo,
> 
> On 17/6/21 9:16 am, Angelo Dureghello wrote:
>> Add flexcan support.
>>
>> ---
>> Changes for v2:
>> - add irq resources for ERR and BOFF interrutps
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> 
> You should put your signed-off-by above the first "---".
> Tools like "git am" drop everything below the first "---" and before the
> patch proper. So it ends up losing your signed-off-by.
>
Oh ok, thanks.

> Regards
> Greg
> 
> 

Regards,
-- 
Angelo Dureghello

