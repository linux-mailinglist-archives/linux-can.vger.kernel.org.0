Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31CE33208F
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 09:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhCIIac (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 03:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhCIIaR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 03:30:17 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A579C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 00:30:16 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f1so25672509lfu.3
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kZFd+XZ5Ze1AiCBZl14c8mEkDNV3+D55AzM5OcEAkUE=;
        b=RA1AXgztRKbfIhedIxrgPoghvZO+8j/HhLP/jfvO0jLzSKfh1PBQD1wrdek/4rpa8z
         Xi04XiR9zsnAN8uvTgfrfm5P6OI8l9Vd4hVF/gDWL3Qzx2d4JkB84BXlZuI3mDWz27sx
         vnekqocP6OjhuZmO4JMUlgio6eec0ZwGMWDzx8ar5fKmzoN2T81ZKr2o71taEdUKYlUa
         dx5sTXhAuGay6WIau9/+aS2GzbK0/zQ7qT8wMVKGQaAZiBcMTyHJVMF8sIbeN3pxLck5
         f6tGXI2E2KpB/qf5NU1Q1Qrnsauu+gHFIqMEFRp30WFtGQtv50TOavJQOvxUWkdX99S9
         tk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kZFd+XZ5Ze1AiCBZl14c8mEkDNV3+D55AzM5OcEAkUE=;
        b=s8F/6ot/8qwVQQ8S21LaXqq1+IO31hR7vcvAOVAX7LERpGb4fzpELcwmr8CX/KHRPw
         YYTYEidZf15wvq86EE3pA4o2Ej8c3BShfDDO7esxU0Rzt4MLpxJS8a0NvrTM98/B1nkw
         m+VlLYJG2gAre2Rw8SI2ghayEgplRBFHO0iNMgC6wm30V/T/m/WuWXVxpMHAkys9EyP5
         mqTL9B9e1HxpZhbko5msuIfa7/Hicd0mViXR178ZHzJnR+PTX8zCDPOQaK/pqARPVj9A
         RSJsuEBvCCCFIInx2jU9QzUEKpNn2e5Tbkcm1ZE5OLu0Q+iD0QKC9B+M78GcNyZwl6Ww
         zRsw==
X-Gm-Message-State: AOAM531PU57VMGWjLphooU/Pi2L9jp4AHYBOHXQwQTVnqPXreLbnujN6
        G0jnRJVVhLNidyg5QuJU+oQtjGI4OiE=
X-Google-Smtp-Source: ABdhPJwwSJ6xmicbYSKxN1rgqWTfMyZgkPrsNY06OoF6I9lyQ9hPiYdwsd9m43d5O40iAK0i1I35xg==
X-Received: by 2002:a05:6512:969:: with SMTP id v9mr9104277lft.466.1615278614853;
        Tue, 09 Mar 2021 00:30:14 -0800 (PST)
Received: from [192.168.16.194] (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.googlemail.com with ESMTPSA id t16sm1800667ljj.137.2021.03.09.00.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 00:30:14 -0800 (PST)
Subject: Re: [PATCH v12 0/1] Introducing ETAS ES58X CAN USB interfaces
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
Message-ID: <2f2db145-0d70-0795-2dda-54f5ade68681@gmail.com>
Date:   Tue, 9 Mar 2021 09:30:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-03-08 17:34, Vincent Mailhol wrote:
> Here comes the twelfth iteration of the ETAS es58x usb driver. The
> major difference from previous version is the total removal of
> spinlocks. Aside of that, I also implemented the TDC accordingly to
> the patch series which I submitted here two weeks ago.
> 
> This patch series is based on linux-can-next/testing. It requires the
> latest patches in that branch to compile.
> 
> Crossing fingers, hoping that we are now close to a release.
> 
> Thank you in advance for your review and for your time!
> 
> 
> Yours sincerely,
> Vincent

Hi Vincent,

Can you please send me the patch, since it does not reach the mailing list (+100 000 characters).

Regards,
jimmy
