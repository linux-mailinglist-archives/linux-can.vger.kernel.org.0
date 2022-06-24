Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D092559E9A
	for <lists+linux-can@lfdr.de>; Fri, 24 Jun 2022 18:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiFXQbK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Jun 2022 12:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiFXQbK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jun 2022 12:31:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDCE50B2A
        for <linux-can@vger.kernel.org>; Fri, 24 Jun 2022 09:31:09 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r133so3253921iod.3
        for <linux-can@vger.kernel.org>; Fri, 24 Jun 2022 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=42vqXHuiZ9lUJjbA2pfwnVdZIl0tCd1lnlfeS2c09o8=;
        b=RdMOSt9wBjBPkoVnwIYFV+VWkAATYKxJkmR6c2wP03QQrnPnEPVstOUHv72i6D0Eag
         8SqoitFjIH/S8uacVOj2LyJdXIKFjWUpj+Lt6uhPElN+EdbdcBfpVVunGnZ3P9GeCMsV
         GFw++SB20sFA9doxngusBTyA8m1dXVk/ld/lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42vqXHuiZ9lUJjbA2pfwnVdZIl0tCd1lnlfeS2c09o8=;
        b=KBLuUzOn5m++u1+Ie7ak1JsnLy0qiyS8DQ/Uj5Q5nNPjhOieUfqc5wi+d5b3eMUV0c
         sULl8OWXoZcDegdVJYr5DKwFyePlECZs/flTyWyA/T0pEyVfK+kGaKAxPh0xvffylvBe
         +6+occF6k+Lbe07cX/pZFwv7n6uSAdcUIq07ftJpCUkqC3ctzlwxJHEpTm0QYX14olvh
         EKtFOsLt/00wRe06miLdeg54Pde7y3TUl3eZ+l3xgwwjiTf8Fk0LlTeICya8oyxtYFTy
         4Az8PkITFbpdnj0oVuONTUMngrDHCFefu1EDCn56tvP9N5xqwrthpc48iuf6aMTCmDEk
         MiKg==
X-Gm-Message-State: AJIora9uXo3019ar0QVUaIP4G7wSysOGDK0DhpdcN7tEcvA82XJd13Ls
        KefM029TPoX8Q0TBTCcnfWBSYw==
X-Google-Smtp-Source: AGRyM1sahCDCNcX7Yf0xMwht08Evwx8yKQuTO2jO/VzugNl12Q27ofkLUPw6J1t5eNZJ4g7Xw354jg==
X-Received: by 2002:a6b:b842:0:b0:669:b35b:fb66 with SMTP id i63-20020a6bb842000000b00669b35bfb66mr8027574iof.108.1656088268262;
        Fri, 24 Jun 2022 09:31:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b201-20020a6bb2d2000000b00674c8448c3csm1445557iof.6.2022.06.24.09.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 09:31:07 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Hongren Zenithal Zheng <i@zenithal.me>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com> <YrSjRvb8rIIayGlg@Sun>
 <143b863d-c86b-6678-44e6-38799391fa36@linuxfoundation.org>
 <YrXNltWSYbplstPx@rowland.harvard.edu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aaf64d6c-1893-67ed-013e-67d21c8be152@linuxfoundation.org>
Date:   Fri, 24 Jun 2022 10:31:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YrXNltWSYbplstPx@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 6/24/22 8:43 AM, Alan Stern wrote:
> On Thu, Jun 23, 2022 at 11:45:13AM -0600, Shuah Khan wrote:
>> On 6/23/22 11:30 AM, Hongren Zenithal Zheng wrote:
>>> On Fri, Jun 10, 2022 at 05:33:35PM -0400, Rhett Aultman wrote:
>>>>
>>>> In order to have all the flags in numerical order, URB_DIR_IN is
>>>> renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
>>>> value 0x0200.
>>>
>>>>    #define URB_FREE_BUFFER		0x0100	/* Free transfer buffer with the URB */
>>>> +#define URB_FREE_COHERENT	0x0200  /* Free DMA memory of transfer buffer */
>>>>    /* The following flags are used internally by usbcore and HCDs */
>>>> -#define URB_DIR_IN		0x0200	/* Transfer from device to host */
>>>> +#define URB_DIR_IN		0x0400	/* Transfer from device to host */
>>>>    #define URB_DIR_OUT		0
>>>>    #define URB_DIR_MASK		URB_DIR_IN
>>>> -- 
>>>> 2.30.2
>>>>
>>>
>>> I'm afraid this is a change of uapi as this field is, unfortunately,
>>> exported by usbip to userspace as TCP packets.
>>>
>>> This may also cause incompatibility (surprisingly not for this case,
>>> detailed below) between usbip server and client
>>> when one kernel is using the new flags and the other one is not.
>>>
>>> If we do change this, we may need to bump usbip protocol version
>>> accordingly.
>>>
>>
>>
>>> A copy of Alan Stern's suggestion here for reference
>>>> I don't see anything wrong with this, except that it would be nice to keep
>>>> the flag values in numerical order.  In other words, set URB_FREE_COHERENT
>>>> to 0x0200 and change URB_DIR_IN to 0x0400.
>>>>
>>>> Alan Stern
>>
>> Thank you Alan for this detailed analysis of uapi impacts and
>> usbip host side and vhci incompatibilities. Userspace is going
>> to be affected. In addition to the usbip tool in the kernel repo,
>> there are other versions floating around that would break if we
>> were to change the flags.
>>
>>> One way to solve this issue for usbip
>>> is to add some boilerplate transform
>>> from URB_* to USBIP_FLAGS_*
>>> as it is de facto uapi now.
>>
>> It doesn't sound like a there is a compelling reason other than
>> "it would be nice to keep the flag values in numerical order".
>>
>> I would not recommend this option. I am not seeing any value to adding
>> change URB_* to USBIP_FLAGS_* layer without some serious techinical
>> concerns.
>>
>>>
>>> Another way is to use 0x0400 for FREE_COHERENT.
>>> usbip will not take care of this bit as
>>> it would be masked.
>>>
>>
>> I would go with this option adding a clear comment with link to this
>> discussion.
>>
>>> Cc Shuah Khan here since she is the maintainer
>>> on usbip.
>>>
>>
>> Thank you adding me to the discussion.
> 
> I can see this causing more problems in the future.  There's no hint in
> include/linux/usb.h that any of the values it defines are part of a user
> API.  If they are, they should be moved to include/uapi/linux/usb/.
> 

Please elaborate on more problems in the future.

> In general, if a user program depends on kernel details that are not
> designed to be part of a user API, you should expect that the program
> will sometimes break from one kernel version to another.
> 
> Yes, I know Linus insists that kernel changes should not cause
> regressions in userspace, but the line has to be drawn somewhere.
> Otherwise the kernel could never change at all.
> 

I have had to change the usbip sysfs interface api in the past to
address security bugs related to information leaks. I am not saying
no. I am asking if there is a good reason to do this. So far I haven't
heard one.

thanks,
-- Shuah
