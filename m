Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D3233255E
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 13:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCIMWD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 07:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCIMVb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 07:21:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C8C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 04:21:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u14so15093814wri.3
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 04:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T7wBAvLpBXpPfZk0ZSyFEaLT8X/+CsWVzUA8OjJ+mW4=;
        b=ei3oP1EP4qLj45xlo8OWwhq4qwB7bR2PpKV1vjcTupN7TI/277iqUG4rLIQcxdDVDE
         +YPLiBQyqMehHW7Kehx6+yYTCSMZkENliLQZJrTI1BANgWP9C4zlu+rweKC611c9DrH4
         AUOW7hXE8qpNCeRfvplQyrBaQ188+kWX9P/UxDP43lXGmpBTqLICxuwt9qoSS47mDxoi
         3Cvk0x/PQmMjgf5QVN/TFhCjsc8SySxtSaKGJv3iuO026wKVoplfjM46fyiXSWO1kMuX
         yNwZfWDL2mk2yBx6L7TXhxmdkmVFl8NSBdWWjt78XPbINQACPm0gbsn521VY3t1MJtHk
         LGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T7wBAvLpBXpPfZk0ZSyFEaLT8X/+CsWVzUA8OjJ+mW4=;
        b=X3+eZ3boKYDAjiLssAhB5XHC/0RlAOtlj62aiHo0BPDo4VY1yaPjVd8XDt4TvnNc+y
         e5Md9lLSe9E6dyGdYpTnDqmCFuSKY7ng0haktXZehX9zGzh0h0OiD+u2qH/HU9n9fnXk
         VVRu/xFB6d7ep/N1lRDENEnAwyAInMAbMHkyE0QmK7mBQxQmT/tGRGvN2a5rG/eBOD+l
         IT7iSfYxPTQ2mtL6srM+8V10bEa5nQ5UKtrnQLZCnJT3kgJukJZx0dB2ywUQXGnCeVSQ
         kLaU8UD1Jh6+lLuhZBzikz3DcK0j96Q4YgI3tX/MHS+yVIegkS965WVjEpDPuHmI6ZOi
         Ih4g==
X-Gm-Message-State: AOAM532mVqlT0MgFayNUXaFfCe5P/YMO7Yb6GXmXqSjO3WWHvGMU2BGn
        qXuhpUYRldfFZAR+J8e9lCJ/LE8HZQbGaA==
X-Google-Smtp-Source: ABdhPJzFCJHIqhpncXvl/EF7BWuywQqSoM8BZrzD56sN/uNqMj/kNUGWJetsP8tKp6M/EbhcLf7Ylw==
X-Received: by 2002:adf:f852:: with SMTP id d18mr28601860wrq.210.1615292488210;
        Tue, 09 Mar 2021 04:21:28 -0800 (PST)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id u20sm27420989wru.6.2021.03.09.04.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 04:21:27 -0800 (PST)
Subject: Re: [PATCH v12 0/1] Introducing ETAS ES58X CAN USB interfaces
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
 <2f2db145-0d70-0795-2dda-54f5ade68681@gmail.com>
 <CAMZ6RqKExqbVkJ+efo=ROU3v1biRNFPzs3P3=p+yF7bTAUFY-g@mail.gmail.com>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <d2a4de17-25ca-3331-206d-181909a4400d@gmail.com>
Date:   Tue, 9 Mar 2021 13:21:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqKExqbVkJ+efo=ROU3v1biRNFPzs3P3=p+yF7bTAUFY-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-03-09 13:18, Vincent MAILHOL wrote:
> Hi Jimmy,
> 
> On Tue. 9 Mar 2021 at 17:30, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
>>
>> On 2021-03-08 17:34, Vincent Mailhol wrote:
>>> Here comes the twelfth iteration of the ETAS es58x usb driver. The
>>> major difference from previous version is the total removal of
>>> spinlocks. Aside of that, I also implemented the TDC accordingly to
>>> the patch series which I submitted here two weeks ago.
>>>
>>> This patch series is based on linux-can-next/testing. It requires the
>>> latest patches in that branch to compile.
>>>
>>> Crossing fingers, hoping that we are now close to a release.
>>>
>>> Thank you in advance for your review and for your time!
>>>
>>>
>>> Yours sincerely,
>>> Vincent
>>
>> Hi Vincent,
>>
>> Can you please send me the patch, since it does not reach the mailing list (+100 000 characters).
> 
> I resent it. It is now available at: https://lkml.org/lkml/2021/3/9/456

Great :)

> Also, I guess that your main interest is the TDC. If so, please
> check function es58x_fd_enable_channel() and structure
> es58x_tdc_const both in es58x_fd.h

Correct, thanks!

Regards,
jimmy
