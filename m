Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F303B9E19
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGBJZc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 05:25:32 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:33578 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhGBJZb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 05:25:31 -0400
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id bd7c89c1;
        Fri, 2 Jul 2021 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=default; bh=+/QQhGpJa
        s1OI5XmZhyeGguU/PE=; b=eRYybGcPxT7KYZwgfDj6uwAyTMNFaNiGIJoZ1flTa
        FT+No1s891qd/LiCuh6rYNsSGQSxdyElM4ONHC4j90t/gVrW51SGu7Q0sBnUklP0
        x6/0YHfkbrQLa3vSI9i62fkcSdUOKqe3j7nVCPXtPV4Jo+ht30jFoieg9hwHE1iM
        tU=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=default; b=gcR
        /UWPuwu7EcQFx4tbTgt8aujCsN8tkELSXuRwPjbhr/eEdvOi47i1FRvIw597NA9Q
        HKQ4FI2yjGnSuzUtMXQ6mTufHIfd2hm4+5MP2vNplHPER5NcT7eGrIsVCRLFn0sa
        znTmOQ80z7DSPFDldkikEQfXrdC220+qLGIQi8Fs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1625217776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNBTGZ2ulecHUbnbNN8f+/GRNYO8pU0qOY5eRTpjzBs=;
        b=bJuonDZII+Ia1qKL2apIv7Qaz1eJs8liAAjs7jXK9yV92vqEMdII4Ne/rIi4XLSBAYOLlt
        2t9zw1LyLPMnSwtNmFLlxH+N9hTGULmbOAA1k5HzlGdTFVgwtS8AmxnCI9CSWpU4Zmn9KU
        o02B1LYUX6tXxnZNyCqK1Mi8HRiGc/k=
Received: from [192.168.0.2] (<unknown> [95.236.232.230])
        by ziongate (OpenSMTPD) with ESMTPSA id 9233ec65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jul 2021 09:22:56 +0000 (UTC)
Subject: Re: [PATCH v4 1/5] can: flexcan: add platform data header
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210701092738.iw4l4vekpvn2c4an@pengutronix.de>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <eca22abd-7aff-5113-3cc7-a8abf10062e1@kernel-space.org>
Date:   Fri, 2 Jul 2021 11:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210701092738.iw4l4vekpvn2c4an@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 01/07/21 11:27 AM, Marc Kleine-Budde wrote:
> On 01.07.2021 01:00:12, Angelo Dureghello wrote:
>> Add platform data header for flexcan.
> 
> BTW: the DKIM signatures on your mails are invalid:
> 
> |   ✗ [PATCH v4 1/5] can: flexcan: add platform data header
> |     + Link: https://lore.kernel.org/r/20210630230016.4099050-1-angelo@kernel-space.org
> |     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> |   ✗ [PATCH v4 4/5] can: flexcan: update Kconfig to enable coldfire
> |     + Link: https://lore.kernel.org/r/20210630230016.4099050-4-angelo@kernel-space.org
> |     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> |   ✗ [PATCH v4 5/5] can: flexcan: add mcf5441x support
> |     + Link: https://lore.kernel.org/r/20210630230016.4099050-5-angelo@kernel-space.org
> |     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> |   ---
> |   Attestation is available, but did not succeed:
> |     ✗ Failed DKIM/kernel-space.org attestation
> 

thanks for catching this, fixed, now dkim tests are passing.


> Marc
> 

Regards,
angelo
