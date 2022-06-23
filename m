Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD05587C4
	for <lists+linux-can@lfdr.de>; Thu, 23 Jun 2022 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiFWSms (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Jun 2022 14:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiFWSmd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Jun 2022 14:42:33 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3EAE5F9B
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2022 10:45:16 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z191so147369iof.6
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2022 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7P0VnowkKfoDkKbuiU+Xuw4hgqalGNoH5b/AffN9UdQ=;
        b=UGICKkw3StwwQc9Nqa+T+7dDGGuRiop4MYF4G2855GjQBWnBUubcGFapfBJX8lUDkL
         Zn0oTcJiQLJun0K/zDxbc3mLrk1IK1F9/DAKXRUMfVjb7ZP2s4NHIggjbROyTjXFmka0
         IPnGUTUyjUOhRwjlM2iObAPBnIWWspLETloAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7P0VnowkKfoDkKbuiU+Xuw4hgqalGNoH5b/AffN9UdQ=;
        b=YQBWkkF13qzZJFmFFW3WXzGYlsNKmaUB9YCLBxqGYUtpQrMuKISGxaQrjw75CsSPmE
         fH69peVinWq2q/0ms1U1pf0icmPyv+OQs+RfwQMd/mD1r43cWaxT3Uj2/cUFZUZ28iUv
         swCXsiCmfnbG50+Z7QxlHiR0+Y3rBIXOxCMNaPmFL+thLKqR/M+ikbop1mM/F2pKfens
         XxVgiNFhosfO0VJRtYuaGWE62Jca4Q3wk2osi7eUhLHR2A4gVGu6p7nx7DvN4McTbru8
         DjB6E55G9nBs8lIsHdx82f1PhrOGyacoHy44FHVrkIa8syS5pyFaqQoP5xdaaK9AJhOi
         IDDA==
X-Gm-Message-State: AJIora/MafJ5Q8glPitZ67BakS5Vsw+RTZHu6MVQmahfZAM+i7flX18B
        9tOCR6ePXrG5uVNDJ2NmdO75eA==
X-Google-Smtp-Source: AGRyM1tSLLX5uT1PsRsPH4ZHPLQUbi897lNFKPUCRBOGLmyml9cakeS+1dxaCyXUxybg+MGUR6t+SA==
X-Received: by 2002:a02:6d2b:0:b0:332:1027:a2dc with SMTP id m43-20020a026d2b000000b003321027a2dcmr6118023jac.65.1656006314957;
        Thu, 23 Jun 2022 10:45:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u9-20020a056e021a4900b002d946b38ce2sm83556ilv.46.2022.06.23.10.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 10:45:14 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Hongren Zenithal Zheng <i@zenithal.me>,
        Rhett Aultman <rhett.aultman@samsara.com>
Cc:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com> <YrSjRvb8rIIayGlg@Sun>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <143b863d-c86b-6678-44e6-38799391fa36@linuxfoundation.org>
Date:   Thu, 23 Jun 2022 11:45:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YrSjRvb8rIIayGlg@Sun>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 6/23/22 11:30 AM, Hongren Zenithal Zheng wrote:
> On Fri, Jun 10, 2022 at 05:33:35PM -0400, Rhett Aultman wrote:
>>
>> In order to have all the flags in numerical order, URB_DIR_IN is
>> renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
>> value 0x0200.
> 
>>   #define URB_FREE_BUFFER		0x0100	/* Free transfer buffer with the URB */
>> +#define URB_FREE_COHERENT	0x0200  /* Free DMA memory of transfer buffer */
>>   
>>   /* The following flags are used internally by usbcore and HCDs */
>> -#define URB_DIR_IN		0x0200	/* Transfer from device to host */
>> +#define URB_DIR_IN		0x0400	/* Transfer from device to host */
>>   #define URB_DIR_OUT		0
>>   #define URB_DIR_MASK		URB_DIR_IN
>>   
>> -- 
>> 2.30.2
>>
> 
> I'm afraid this is a change of uapi as this field is, unfortunately,
> exported by usbip to userspace as TCP packets.
> 
> This may also cause incompatibility (surprisingly not for this case,
> detailed below) between usbip server and client
> when one kernel is using the new flags and the other one is not.
> 
> If we do change this, we may need to bump usbip protocol version
> accordingly.
> 


> A copy of Alan Stern's suggestion here for reference
>> I don't see anything wrong with this, except that it would be nice to keep
>> the flag values in numerical order.  In other words, set URB_FREE_COHERENT
>> to 0x0200 and change URB_DIR_IN to 0x0400.
>>
>> Alan Stern

Thank you Alan for this detailed analysis of uapi impacts and
usbip host side and vhci incompatibilities. Userspace is going
to be affected. In addition to the usbip tool in the kernel repo,
there are other versions floating around that would break if we
were to change the flags.

> One way to solve this issue for usbip
> is to add some boilerplate transform
> from URB_* to USBIP_FLAGS_*
> as it is de facto uapi now.

It doesn't sound like a there is a compelling reason other than
"it would be nice to keep the flag values in numerical order".

I would not recommend this option. I am not seeing any value to adding
change URB_* to USBIP_FLAGS_* layer without some serious techinical
concerns.

> 
> Another way is to use 0x0400 for FREE_COHERENT.
> usbip will not take care of this bit as
> it would be masked.
> 

I would go with this option adding a clear comment with link to this
discussion.

> Cc Shuah Khan here since she is the maintainer
> on usbip.
> 

Thank you adding me to the discussion.

thanks,
-- Shuah
