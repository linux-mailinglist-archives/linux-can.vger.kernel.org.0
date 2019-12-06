Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988AA11544A
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 16:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFPbt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 10:31:49 -0500
Received: from first.geanix.com ([116.203.34.67]:39628 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLFPbt (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 10:31:49 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id C9FB93E0;
        Fri,  6 Dec 2019 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575646300; bh=RsYzJwlH6NtsP9rdYkxfcjYh0v9Tg7ey3C/WV5Ytp/s=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=i7NdqgLTViGTsK1hkhbhvLL2GkUonkwvtFk+i+Wt8PcAo/pCxb/ObelVfDinLkCTn
         YL9uP5woAvMh1EUW1lyiSzb8rJJpBv2OZgw7zCR208mmX3LPyN9aU2EBZ8EE5hm8KW
         8xhtE/Wd24mb8OAJ3fvnMbp6vq0KzXyyo/+NQGUfjGSdnm+s1B+xUVUrkmWmwTnYlK
         /d2oeOFSFa5SkjJD+M0vxKBx3/PP22SNTaEG4DU0LwV91yDjMtC2ncI1xebA6h0xN9
         HJoKek3V40S+CgYgho8Eh8IUQvMMVxKZAEecjyhF9Iz5oUiLbs/J9edtVQGWmZVMqz
         UEIut+1ByvGjw==
Subject: Re: tcan4x5x
To:     Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
 <17034589-01c5-701b-e5c3-db8972c5ade0@ti.com>
 <e5cf55ef-57ff-c3a9-fc2f-06a3c8fb1206@geanix.com>
 <aa43b6ed-ff52-0c04-8478-945409149f6a@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <70540af8-ebba-92a0-3d65-28385cb72015@geanix.com>
Date:   Fri, 6 Dec 2019 16:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <aa43b6ed-ff52-0c04-8478-945409149f6a@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 06/12/2019 16.16, Dan Murphy wrote:
> Sean
> 
> On 12/6/19 7:54 AM, Sean Nyekjaer wrote:
>>
>>
>> On 06/12/2019 13.56, Dan Murphy wrote:
>>> This is the INH pin.  This is what our HW guys asked for.
>>>
>>> We probably can make this pin optional as well.
>>
>> Oh the INH pin is a high voltage output, for my device 12V :-)
>> No really suited for a GPIO input...
>>
>> So please make that optional as well
>>
> Just checked it is optional already
> 

Yes i see :)

With regards to "(unnamed net_device) (uninitialized): Failed to init 
module"
I'm making some progress there is something going wrong in the CCCR 
register, in m_can_niso_supported()

Will continue on Monday..

/Sean
