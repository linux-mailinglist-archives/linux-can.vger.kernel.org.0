Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C3A26CCD5
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 22:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIPUty (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Sep 2020 16:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgIPQ4e (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Sep 2020 12:56:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F18C025269
        for <linux-can@vger.kernel.org>; Wed, 16 Sep 2020 05:17:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id e4so3092514pln.10
        for <linux-can@vger.kernel.org>; Wed, 16 Sep 2020 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ulNy0GYYo73Nhpta7oZ5nEu1dWhqwaLnuHI7Rdu6wyU=;
        b=ZVX2JTAopg15X134IFNQyjRGZ+lMkS2oseiw5XMndvZzl96fZYL+If1qAKUuoaxoqk
         2I6DMDpOp5AD3YQ/yQV1cczweXyIX3goOQF0q+8IDa0xiy7TSQkF3x5jqnmcQDnVsGBc
         J+lP4ln31Vzs8fMTJ6Id61j2P0pOwKliNtOOL/rJvLpBK9avUnfBpSbpDqV7okyJCBh8
         inZ/cM/irjs5LeuVGFFMwojGUEzZFs243h5fi+/BHLh1RwMP3ZnMq1TS7PfcfDIK4Rcn
         aPdsKRfORMzVwnlpV02uh1J+4jXw6Yww3OMtzg19LRdiUrBRjRJwO00gDEPiM6prdDwe
         +geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ulNy0GYYo73Nhpta7oZ5nEu1dWhqwaLnuHI7Rdu6wyU=;
        b=QP7xTfXKzoJqeBTOMcSHg0+Zo+PpD+6k9S3h85kKhWiOES9oasjxQIj4JACqJjvebz
         ZQOESu2vgwRu65t9aOyXTj3nhTc17XFKj0Lt0Z2g7n3TIGppDV80KaFuiakln1KWkKNR
         zyTkdVDTzSjC/LkcxiqF0tzdAon+ZGDsZNcncWrMMbMBxpJtumTx2JjXPXeBBnXMvrhN
         hWB+OQC4XsLqkvd01R5PKO8U9M9rPZ2ewUdm9VHVoH1djqUmIW3bqHQk0Bu7LUJLI1r4
         DeVBpj/G2sIDlPcF6pmbhXMqphYHTDQRP4qETnhK+sMeCmNt0I4m9sQ7Xfzf7CgwbBtc
         /xGw==
X-Gm-Message-State: AOAM5314mtG6Kemufq+lKl0pICtS2g+wajTfG4zvmRQIlcae5ZnmQ9IO
        SzmhnG41S7YmovT3SIGqjRIM
X-Google-Smtp-Source: ABdhPJzM2b3dXl4SggxQROZIKLRl4JVysPwmHrQs1xG71ZC1d7poRCsAYUqgnLwHRj5I80xXFp32vQ==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr3649905pju.142.1600258630214;
        Wed, 16 Sep 2020 05:17:10 -0700 (PDT)
Received: from linux ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id z9sm16423391pfk.118.2020.09.16.05.17.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 05:17:09 -0700 (PDT)
Date:   Wed, 16 Sep 2020 17:47:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Thomas.Kopp@microchip.com
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add reviewer entry for microchip mcp25xxfd
 SPI-CAN network driver
Message-ID: <20200916121703.GB4281@linux>
References: <20200916101334.1277-1-thomas.kopp@microchip.com>
 <d067727d-0b7d-e147-cc1b-abcbddacd216@pengutronix.de>
 <DM6PR11MB4283850F9D0A341502F8FA0BFB210@DM6PR11MB4283.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4283850F9D0A341502F8FA0BFB210@DM6PR11MB4283.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Sep 16, 2020 at 10:20:51AM +0000, Thomas.Kopp@microchip.com wrote:
> Hi Marc,
>  
> > Can I add your S-o-b? Please include this in your next patches.
> 
> Yes you can. Sorry I missed that and I'll include it in future patches.
> 

Please include the commit message also with a bit of explanation!

Thanks,
Mani

> Best Regards,
> Thomas 
