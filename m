Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334506DEDE7
	for <lists+linux-can@lfdr.de>; Wed, 12 Apr 2023 10:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjDLIhW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 12 Apr 2023 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDLIgz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 12 Apr 2023 04:36:55 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44FF93CB
        for <linux-can@vger.kernel.org>; Wed, 12 Apr 2023 01:35:27 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id gb34so26994297ejc.12
        for <linux-can@vger.kernel.org>; Wed, 12 Apr 2023 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681288407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbszsCLhH7dSat1uaHWblB5wKFKCQ+YgLYmMZO1y5Eo=;
        b=HEtYkx9DreBQFNDWzOxkydeEgdY/SyaJQpZaaNGmF0gE6yzD6B4LgnLh1d76f4boJu
         l8/Dlv8xsU+WGCQCJFjXunvBnLcpi9ihFPiDu/o239c75s9+PrtinaTnuaV50NVpovk2
         vuljXjd5KfHj47hcH1kQhKcIBKtmulYnjPrap4CIv/ewJAPlbVWCEf0V2FK1lmDziELT
         TNDql4LpmLkHrmP+aBXxO//aQldgw/xsCZzBLDxAj2YtYAMfap3GSrhN2q6DKPiWDRSZ
         ZIlpZhl/fFHsrpY5hnPLpUyP3LaCFsAHa8ppxQbl+wK3O44pGXKEKAhdh9EaFLiV/gE2
         2pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681288407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbszsCLhH7dSat1uaHWblB5wKFKCQ+YgLYmMZO1y5Eo=;
        b=Nm3fpdwuwaaWzDUM+FTkWb8hRpYA02K5urMcOiVjl1uFkAs0w/cY6i2z4wYMJ9sASl
         rRbLshsKG3LW05+fdEY6EA4Zdyg/MWzcAHtoOBB8+MxHOBNZbKUSQy60OMwtv4vtQ9TM
         s166XcDCupkHgoOUn3rQbFxr6gSyKEa9gdVq7ZN44Pf/3wMUMoTJg+T4imLPlFiwYLmL
         NolQjjeCnkG4lvOPWZ76yKzS1lkdNgdDmq6z3qs6FNu+VcvDEWZSFYDEUZPQsFVAfHTY
         TT9Qwup2HL4JwszvYqrQ2OV6XzaNqop8aFZ6CKKxgCDsuseF1jmCGOHFvwjWcHPH6N1V
         oVkg==
X-Gm-Message-State: AAQBX9fE+9KsRxhw+pkvIlRwTo+DfjBp/2/I6MjLS6X9plgLhxM8fEyP
        qQ1g9SDpHyoiWByuPQqbGwtdDw==
X-Google-Smtp-Source: AKy350bh/ykZfhUBvfjxuhwpZnfQZoxwrFvY5TQmVDFochTB98sNor8ERoBzAQ8JrrX4gfTcRMDpEg==
X-Received: by 2002:a17:907:75fa:b0:94b:d57e:9d4e with SMTP id jz26-20020a17090775fa00b0094bd57e9d4emr7529315ejc.3.1681288407095;
        Wed, 12 Apr 2023 01:33:27 -0700 (PDT)
Received: from blmsp ([2001:4090:a244:813c:8d8e:4cbf:6b2c:84d4])
        by smtp.gmail.com with ESMTPSA id m10-20020a50d7ca000000b00504af12df9fsm2397165edj.31.2023.04.12.01.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 01:33:26 -0700 (PDT)
Date:   Wed, 12 Apr 2023 10:33:25 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/16] can: m_can: Optimizations for m_can/tcan part 2
Message-ID: <20230412083325.fpgix3jaag6e5m65@blmsp>
References: <20230315110546.2518305-1-msp@baylibre.com>
 <20230324183257.qpis4cip5cp4gebu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324183257.qpis4cip5cp4gebu@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc and Simon,

On Fri, Mar 24, 2023 at 07:32:57PM +0100, Marc Kleine-Budde wrote:
> On 15.03.2023 12:05:30, Markus Schneider-Pargmann wrote:
> > Hi Marc and everyone,
> > 
> > third version part 2, functionally I had to move from spin_lock to
> > spin_lock_irqsave because of an interrupt that was calling start_xmit,
> > see attached stack. This is tested on tcan455x but I don't have the
> > integrated hardware myself so any testing is appreciated.
> > 
> > The series implements many small and bigger throughput improvements and
> > adds rx/tx coalescing at the end.
> 
> I've applied patches 1...5 to can-next.

Thank you both for your feedback, I appreciate it. I am a progressing a
bit slower on this project right now but I will address your feedback.

Thanks,
Markus
