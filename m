Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7A32637D
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 14:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBZNqK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 08:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBZNqG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 08:46:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3496FC061574
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 05:45:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w11so8613800wrr.10
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 05:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LUNVpTSD2FXDEQGiBimJ/0upbKEZDwzlsPp19Aj4MsM=;
        b=sNtPZgcnLL4c1z7GOdOSK2hlIIzm/cRiQmFWu/D8fAVDkiB6cXfOxNtDbGpPnZzNbd
         1KiIZOPEbuNUYTSujDrtlZgrxCrLLzoMRNjdrNXd3L+QWCCPNByCu37JTp1OcD/yY4Tr
         bM1Bqd5MS0lLdmiFOAIw/cSVmbvgWLGJuW+n9GSzfyJ/Lfdc1OXz/xnk8bAtIuIfbac1
         PWnUri70qAOAFeM07EaaHFgn8VxJATZkvaGqT4BTxCGt0RxdBRW6qWo4C5GFoQZCYVwQ
         tll3LDpZi4+KFYmWWJvjz989PRmgj9gW11MlTq0UCX3X3mOHuVzpA5BNYkO/sK5UuZmi
         TPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LUNVpTSD2FXDEQGiBimJ/0upbKEZDwzlsPp19Aj4MsM=;
        b=unazXsI25wrJnWyzQ1hMixsXvHrauRZ7ayC1orbUEdjUSr16QER4Ab0To/gZX4Vro1
         Peo+zLJ3/MWHg8QS5DF+/gAjB2PqP9efBO/tI/C68DqjyjVj9Jb8abruWbeXVQqIgRv1
         To1So7+b7OIgw/nmYQOEWWYFdH95O510nKQloQaec9QfFeT4qqIXeJ92A6cyqAcvOS79
         JPikKwUc2S6D20WiVr8XwudALIox2nrtqix+VrvYJkCq7vs1bUrSoSxZf/EmNO3fadRx
         rp8sahmcJ6Z0h2kGBbI0n0G/9R2viHE8uuXzAjqywdPzfU0ICqJbHmw1WD86P6XqunME
         raeA==
X-Gm-Message-State: AOAM533+Pd2QlNhkgod7MtjgQGSiAfuANE5Jb1IzMq8xD/d9DQtI1NiF
        05oLr9yA7MfPnQOheo7h+6EU/w==
X-Google-Smtp-Source: ABdhPJw8KCToUaojvY+LIEL89sUi8NUiAJ0AMxWdomWZdET4ToQ0FK9n7ahGlbEw6WgAXF+k3w0WSw==
X-Received: by 2002:a05:6000:1546:: with SMTP id 6mr3301326wry.398.1614347124961;
        Fri, 26 Feb 2021 05:45:24 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id z21sm11885380wma.29.2021.02.26.05.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 05:45:24 -0800 (PST)
Date:   Fri, 26 Feb 2021 13:45:22 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226134522.kd3oxtx3u4ltjxos@bigthink>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <20210226121854.4gb5yufb23hyar73@bigthink>
 <7254df67-202f-ac23-c45c-fcb5172a70a3@pengutronix.de>
 <20210226123144.cwhjberqeyjctc6w@bigthink>
 <2aebafa3-6a18-7d14-b32d-e17909d3d6a8@pengutronix.de>
 <20210226132620.wfuvywkzmhwfmhpc@bigthink>
 <20210226133936.q3o7hrshyurhj3ke@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210226133936.q3o7hrshyurhj3ke@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Feb 26, 2021 at 02:39:36PM +0100, Marc Kleine-Budde wrote:
> > Am I correct in saying that rx-offload requires RX timestamps to be
> > available?
> 
> Proper timestamps for RX and TX would be best, but you can use
> can_rx_offload_queue_tail() if you don't have any timestamps.
> 
> > They can be enabled in M_CAN, but the v3.3 manual states that
> > the internal timestamp generation (apparently only option for tcan4x5x)
> > cannot be used for CAN-FD.
> 
> Can you give me a reference to this?

Here's the manual for 3.3 (annoyingly, I can't find corresponding
documents for earlier M_CAN versions, and TCAN4550 uses 3.2...)

http://www.bosch-semiconductors.com/media/ip_modules/pdf_2/m_can/mcan_users_manual_v330.pdf

See Section 2.3.9, "Timestamp Counter Configuration (TSCC)". Quote:

    Note: With CAN FD an external counter is required for timestamp
    generation (TSS = “10”)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

