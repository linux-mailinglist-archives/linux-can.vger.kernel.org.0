Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3733264B5
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 16:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBZP1T (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 10:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZP1S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 10:27:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6B7C061574
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 07:26:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r3so8940542wro.9
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 07:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YNjLd2DOq2VhzK3BXqb3mq/o+qEkf/7YainwO2/2Kbw=;
        b=rwOqtgA5oslyECFOGBbX9QsLkkoqehfc6U9TyknPzclVM+kd0lHFp0yha/oWc2Wf9/
         RSYxewqxjkMITo65LgE1gqI/LD11/xYkvOZYEGs1Wo7N1QrplblLuaW5ko3WIqDjwLv5
         ZpusL6E/ZIhsY+zTbl25L82U+VCA+bsGa0L3H/bJwKmfdO+UVLiYb2ZlZXWNxH4kPIUv
         mtXYxGl/+phV0bof7Q4p/L/zmoRjpR0iLFrss1tSfZPDTxa8oJonY+cXMjXUqQ+qBB1I
         8kWE0rNozRGSwpGkAAdz7qLgPj5su7Kb5LXYXrs65Y6gCYT9SRVxNBo1ygNh6l867xka
         qhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YNjLd2DOq2VhzK3BXqb3mq/o+qEkf/7YainwO2/2Kbw=;
        b=RLL+4ceY5FNfsDHKzEwit/l0XOxydzuUfQVdcHsbk1XInKbPwwZEiIbg06PDYB3yFh
         o82sJYf0y4ivnlLBOQUmrPMBZfI3MwkVPDtXHZYzPIiwdmrQH4xAKm329L0usv3dXxBe
         x+Ob1L8l+xcxUYiMkr3GDAueB0zv9i6ZecGxPuuS6YvgGNKCs18g+nwam7SMtxfa+NDr
         yPVeF5hxyoAWDMKsmUFJSeT2gRfYRO2vnvp7NGzI11lny68sfdXkcrDKkmRwWad0IGt9
         PH2QsW8sfQliwNMszfCuiRu5SjAqwRdt0ggmBEuIMs3paMdvIS8wL5fcQQM5Uz1aOOd9
         iD2A==
X-Gm-Message-State: AOAM53040SwyOCX20/qxKVmPqktdTHqKvOj+atfoPyIa7cg7U+9wpuFe
        4oHF1VFBhmm+RqbqVyEnlE0hzw==
X-Google-Smtp-Source: ABdhPJyk0Q25uG5g7iiH04bHkno838ELR7d/bLfYughzmzXRhSLTDH61TeciaDtqTF0/Ht1qrIQg8g==
X-Received: by 2002:a5d:5149:: with SMTP id u9mr3888995wrt.348.1614353195301;
        Fri, 26 Feb 2021 07:26:35 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id h10sm11502164wrp.22.2021.02.26.07.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 07:26:34 -0800 (PST)
Date:   Fri, 26 Feb 2021 15:26:33 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226152633.dkro7ffhye4c72hb@bigthink>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <20210226121854.4gb5yufb23hyar73@bigthink>
 <7254df67-202f-ac23-c45c-fcb5172a70a3@pengutronix.de>
 <20210226123144.cwhjberqeyjctc6w@bigthink>
 <2aebafa3-6a18-7d14-b32d-e17909d3d6a8@pengutronix.de>
 <20210226132620.wfuvywkzmhwfmhpc@bigthink>
 <20210226133936.q3o7hrshyurhj3ke@pengutronix.de>
 <20210226134522.kd3oxtx3u4ltjxos@bigthink>
 <20210226140054.725kihkdgkmtl3xf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210226140054.725kihkdgkmtl3xf@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Feb 26, 2021 at 03:00:54PM +0100, Marc Kleine-Budde wrote:
> https://github.com/hartkopp/M_CAN-User-Manual-History

Great, thanks. I can see this also sits in the linux-can repo which is
handy.

> >     Note: With CAN FD an external counter is required for timestamp
> >     generation (TSS = “10”)
> 
> I suggest to check on the tcan hardware, what's really in the register.

I've just verified that internal timestamping works on the TCAN4550 (in
both RX FIFO and TX event FIFO), with FD and BRS both enabled. The
16-bit timestamps are generated specifically from the nomimal bit times,
and you can prescale up to 16x. \o/

Is timestamp-wrapping a concern for rx-offloading?

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

