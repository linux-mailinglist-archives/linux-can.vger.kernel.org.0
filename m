Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1D3D0D8A
	for <lists+linux-can@lfdr.de>; Wed, 21 Jul 2021 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbhGUKnk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jul 2021 06:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbhGUJe3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jul 2021 05:34:29 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097ABC0613B7;
        Wed, 21 Jul 2021 03:12:01 -0700 (PDT)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id fc018ed5;
        Wed, 21 Jul 2021 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=default; bh=WH9fkuBaC
        W6AXKnQB5kTe3bEZcI=; b=aJC1LttRyCOYIJHk3dMMGRjzmoSMV2i128E8fx9nu
        CrM+rE6ZbT/Bgkv+/MMnzDGDSuiMRXyyOgA/ptcr2KBuPC2B8b2sK9AL60E4aswl
        Y3rkMaSzjHz6RL1R3fBcitZRgK+GxBDUslOiz+WRfitGLxZy8gsxfUjphfUs3qFx
        qI=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=default; b=lJq
        3EJ7N4tjRltDCDhDVzqzOEcY7vkcvhBaJGWfDcDxaDb6byhpx/OzotM8g/2gQmJZ
        obGLrM1mL2JDOjlgtZTZrtoiyoJMS074j0Nfc0tMxVtjDFmEsq6p5BEgwSOmMPoR
        /GrzTxDP6DRgFu+uMCDFm8d15wWkzZibyhDBGv+A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1626861919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tT1drKIFh/pk2IunUXW1WLo26FZPmF/ilo2ON2O/XFI=;
        b=JRt/Xgg3GxPZX12NhSc7zQuxBsl2oslzQlKwdQNOUH7HQdGWEja1ytPbpCpQiOW6bJyrUd
        sii6QkRClEHnOwggnf1KafEx4GAybdtr4+NkE7iDH2VBSLc9cAvDeTnGfI1Iz6IWG+7Dby
        bub1sCNHMq+taWaUuVpmk2efMA3H33w=
Received: from [192.168.0.2] (host-79-44-236-76.retail.telecomitalia.it [79.44.236.76])
        by ziongate (OpenSMTPD) with ESMTPSA id 8b877209 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 21 Jul 2021 10:05:19 +0000 (UTC)
Subject: Re: [PATCH v5 3/5] m68k: m5441x: add flexcan support
To:     Greg Ungerer <gerg@linux-m68k.org>, wg@grandegger.com,
        mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210702094841.327679-1-angelo@kernel-space.org>
 <20210702094841.327679-3-angelo@kernel-space.org>
 <1a95b055-5d14-f43e-81dd-d0a0ddbdb1f1@linux-m68k.org>
 <aaa06e75-bcfa-d6ae-a994-630a74501f6b@kernel-space.org>
 <4a745955-8e43-3024-a004-0db0e084d74f@linux-m68k.org>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <e1e702b8-9124-b063-a17c-217336f8c840@kernel-space.org>
Date:   Wed, 21 Jul 2021 12:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4a745955-8e43-3024-a004-0db0e084d74f@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Greg,

On 21/07/21 1:00 AM, Greg Ungerer wrote:
> Hi Angelo,
> 
> On 21/7/21 4:53 am, Angelo Dureghello wrote:
>> Hi Greg,
>>
>> sorry was away for some vacation time.
>>
>> Is there still any job required here ?
> 
> No :-)
> I modified the change as per my suggestions below - so I could push to 
> m68knommu git tree.
> (Otherwise It does not compile). See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git/commit/?h=for-next&id=64151620227a2fcb13dae0b99b6a1003edb38c67 
> 
> 

Super thanks ! Will check this properly next time.

> Regards
> Greg
> 
> 
> 

Regards,
Angelo

