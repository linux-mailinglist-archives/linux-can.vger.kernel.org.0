Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC53B9E4E
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhGBJjP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhGBJjO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 05:39:14 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7FC061762;
        Fri,  2 Jul 2021 02:36:42 -0700 (PDT)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id 9d3e550b;
        Fri, 2 Jul 2021 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=default; bh=wGDVNkVo7
        Pnf2u+u7nB0Gprx544=; b=WeSMZpsWbqf25Rqy8kSFOGVqX0devzxw9ZeiZJKQc
        wGO86Y0vrAtOsmy++1TSdNfu7I9mGTuZ6Hnn1nWJSHIgYHmveXh2+28z5uUzoSz3
        k+0d1l9yXGhpHLcLk5EHQWVUyp8uEcn/DKvGCt6H2YOIM+KUuM0ShaWz32ar4BiN
        qE=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=default; b=oun
        0fomN/Hsa44z1xmt2HdTUI9+HulnNFqP6fu7K6ju+KWtinu2LSfk9FvaEymCZayE
        0KDg6FgsHQzKMjBEsomXPzjgOvEmVTd2otuwGi3hCzDENbpGrUcaahI6nV02FlEx
        NzaR4CzNNFfUjzlLK9d0rkXYb8C57q7EzAfB+hRg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1625218599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULs19XvL9hbFvvHtcc7gWc/MFaEJel999CuRCAjhfys=;
        b=NWI4ubnktDTppgEDk0qDgFRpf6yykTPjKczlboFW38GmE536zSkOqxogGsfjsgZ3sveSOi
        zQP7g6FaXECu9/6got478ZHCF/1zGgcgdim45kvaFwD0Dw1MaqqqPoBRsqTrePMb2KgE88
        ZMwkuL2W3xeY2lIewpRbKkTe+p9sgPM=
Received: from [192.168.0.2] (<unknown> [95.236.232.230])
        by ziongate (OpenSMTPD) with ESMTPSA id 0576b3af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jul 2021 09:36:39 +0000 (UTC)
Subject: Re: [PATCH v4 2/5] m68k: stmark2: update board setup
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210630230016.4099050-2-angelo@kernel-space.org>
 <20210701065327.maawrm546dkfzxbx@pengutronix.de>
 <7effec9f-e3aa-12d1-fc91-cb7b2c4ae9ab@linux-m68k.org>
 <20210701074255.jutewhpjqxsi7bdl@pengutronix.de>
 <7252e8f0-7d16-4707-d091-784c27911173@linux-m68k.org>
 <CAMuHMdV0nMOO734NAXdhbUmmHJYz781QFZT-k85jbd3hZ=qypg@mail.gmail.com>
 <20210701093701.ixn7rwwtwe6x4rsk@pengutronix.de>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <e15c528d-1507-ffcb-cd4e-ab9f3672c56e@kernel-space.org>
Date:   Fri, 2 Jul 2021 11:35:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210701093701.ixn7rwwtwe6x4rsk@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc, Geert, Greg,

thanks a lot, really happy.

Sending v5 in short.

On 01/07/21 11:37 AM, Marc Kleine-Budde wrote:
> On 01.07.2021 11:10:21, Geert Uytterhoeven wrote:
>>>>> I am happy to take the m68k specific changes (patches 2 and 3)
>>>>> through the m68knommu git tree.
>>>>
>>>> Make it so. \o/ I'll take the rest.
>>>
>>> As soon as the current merge window closes I will pull them in.
>>
>> Patch 3 depends on patch 1 through <linux/can/platform/flexcan.h>.
> 
> I'll take the other patches via net-next, so it might take a while until
> they git mainline.
> 
> Marc
> 

Regards,
angelo

