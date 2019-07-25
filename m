Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0423C74F77
	for <lists+linux-can@lfdr.de>; Thu, 25 Jul 2019 15:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfGYN3t (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Jul 2019 09:29:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50745 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387482AbfGYN3s (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jul 2019 09:29:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so45036658wml.0
        for <linux-can@vger.kernel.org>; Thu, 25 Jul 2019 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tU8YjTmFbALUAn/qrmdPvLulIsSkzB2d5vOtzmfY2Rs=;
        b=QSmEwdLe+YhZkcsz6o4ys0tAUbny3GwZMtN99XRXmdJW1iCZ+Vf5w/In+CBSdd0gHg
         vibClHZKjsQ5r9p6HBHE/H/GgOJk2X6+elUIbON0QW6rgTxwJvqUGQ9yHbtra0efGoNs
         W83ucOFD+C4dzQ7oUHIVDBhfdDQb4we0p+KDsHMlSnYg72/tUWMX3ZZTFsDnQKSagzp3
         /5fqCWCWSPGPtFoHuE2tk0wdqTt2RTmL6SBUIE6hAPQblRStbcdtARk/9JRhp/aOg+/a
         4Mb5/Tq5DHwFlXZrrC18XGiypTMQhfqfVm5Dbu5ShEOWmhs5SWISOep78td+xziV4xUO
         CVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tU8YjTmFbALUAn/qrmdPvLulIsSkzB2d5vOtzmfY2Rs=;
        b=LLIHKDbApfSufcP3m2gi3fqomJQ8NwWBybS34rwgwf6qh3v+r5yFRKLWKgKy3HBd92
         fh6SGduZqre/1AKZ8YbKyCrPrQ4tX6y1zKwbBkwEgVJXiHkv0fJveoEAN7ayfuuRXHON
         wRWFZoTm7vnr5RW+Kqojq3o5ZZP/zxwWIQp+JzaJAB+NPvcTZCITumIbSi+x8LmbiOSX
         Lnj1bSG7AOISbSuIHXosSh0T6pFqddssoy8xOv0WRCRz6O/oOE9G5yqsgERD/c1OQnXL
         blCvGI1XNqYaiIlrPZ3Cka7pKlJaJl8qXL5P0LtrmDW9UHWm/z0ll4f2cEtzU5UTg4WB
         oI8A==
X-Gm-Message-State: APjAAAV/COm40Avuccix3aZOYFbJ1A1GlQLZ93tYj5+xwVDyMtHPQ0o3
        IfVvq0mBUaL1hETude6AsOSJmg==
X-Google-Smtp-Source: APXvYqxLCUPCepcCny7CzWoDDk1ywAgVa3CW+UD6K7NsIV9sI+XkHhXJ84YGrnyVi4MvfOP3KuSWxQ==
X-Received: by 2002:a05:600c:20c1:: with SMTP id y1mr82394008wmm.10.1564061386852;
        Thu, 25 Jul 2019 06:29:46 -0700 (PDT)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id t13sm61665737wrr.0.2019.07.25.06.29.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 06:29:45 -0700 (PDT)
Subject: Re: [PATCH 2/7] can: rcar_canfd: fix possible IRQ storm on high load
To:     Sasha Levin <sashal@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        linux-stable <stable@vger.kernel.org>
References: <20190724130322.31702-3-mkl@pengutronix.de>
 <20190724210328.D91DF21873@mail.kernel.org>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <6b23b091-92d1-b05d-b451-d8c78a990ef3@cogentembedded.com>
Date:   Thu, 25 Jul 2019 16:29:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724210328.D91DF21873@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> NOTE: The patch will not be queued to stable trees until it is upstream.
> 
> How should we proceed with this patch?

I don't know.
Maintainer did not respond, nor to original send nor to resend.
