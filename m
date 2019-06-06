Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3ABB37478
	for <lists+linux-can@lfdr.de>; Thu,  6 Jun 2019 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfFFMpq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Jun 2019 08:45:46 -0400
Received: from mail.iot.bzh ([51.75.236.24]:63826 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFMpq (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 6 Jun 2019 08:45:46 -0400
Received: from [10.18.0.57] (unknown [10.18.0.57])
        by mail.iot.bzh (Postfix) with ESMTPSA id C4F9D40073;
        Thu,  6 Jun 2019 14:45:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1559825140; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fqq0uDcJ6h6lXsTm9uvEDGFq8fL8Ydaw5zzBMRCuvE8=;
        b=aRcuPBT0qAtot4Dut7h4RgDmVXl9InVdjKngtPSCfZHCOGuCUTm1+HjW7oUlxV9s7E4IZJ
        jQsU4/EsZwDfnMkaY9AQCXbQgTECGF9FyUHEIBaxHS6MwMbT8qfj8Uk5qKRsMMCt+oKkO5
        SVxlZPqqtxpC0bfnhNYvi5wAWDwHJzPU+kKKompDqNZRQ6GLCEUx9bCNGCe+j1zwqs9Al0
        E/v6SrNINuRSGWDGy3TJJp7cs39a4VNlLOcHy6MzUXEMX5rx+t31HfMZBhgJLzzjhhtr2K
        zxIJHmdFUY4TYYf8q2PS1fXScR4qWz/tz9BCxTComQ8CGtotU/zOSCPMRayTGQ==
Subject: Re: J1939 in AGL
To:     linux-can@vger.kernel.org
References: <ede28202-7be2-5a2f-bc17-4f3af02471bf@iot.bzh>
 <20190603183523.GA10222@x1.vandijck-laurijssen.be>
From:   "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Organization: IOTBZH
Message-ID: <4698add1-0d49-649e-d44f-cdd4615733de@iot.bzh>
Date:   Thu, 6 Jun 2019 14:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603183523.GA10222@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Kurt,

Thanks for the reply, the compile ran fine with minor modifications on 
patches gotten from v5.1 version. I've not tested at runtime yet but 
should be good.

I'll tell you once done if you are interested. You could take a look in 
the AGL Jira ticket[1] to get the patches, if you want.

What about an integration in the mainline kernel ? Is there any date or 
release planned so far ? Thanks

Best regards.

[1]: https://jira.automotivelinux.org/browse/SPEC-2386

On 03/06/2019 20:35, Kurt Van Dijck wrote:
> On ma, 03 jun 2019 18:25:03 +0200, Romain Forlot [IoT.bzh] wrote:
>> Hi,
>>
>> We are working to support the J1939 protocol, using your works on socketCAN,
>> in AGL (Automotive Grade Linux). We are facing some problems or questions
>> about how to use it. We still have support for LTSI Kernel which is 4.14 by
>> now and certainly will be 4.19 for the next and your work are based on the
>> latest Linux v5.1 version.
>>
>> Backporting them to 4.19 seems easy, we just took the diff at the head of
>> the "j1939" branch of linux-can-next repository as patches and applied them
>> to the mainline 4.19 Kernel. We did the same about the 4.14 but only took
>> the J1939 relative patches with a slight change on drivers/net/can/dev.c
>> patches in the patches implementing the CAN midlayer private.
>>
>> Is it planned to support the 4.19 version in the future as it seems to be
>> the next LTSI version ? And less probable, do you planned for 4.14 the
>> actual LTSI ?
>>
>> What do you think about the way we did to backport the work on J1939 ?
>> Runtime tests aren't been ran for now but we just prove that patches apply,
>> which is not enough for sure, but as the work are limited to the J1939
>> module then we are relatively confident and would appreciate your feedback.
> You could, as an intermediate step between 'patch apply' and 'runtime tests',
> try to compile the kernel with j1939.
> Most of the backporting I did in the past indicated the amount of work
> during compiling.
>
> Kind regards,
> Kurt

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh - www.iot.bzh - +33675142438

