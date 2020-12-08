Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE3D2D30BE
	for <lists+linux-can@lfdr.de>; Tue,  8 Dec 2020 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgLHROZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Dec 2020 12:14:25 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:41199 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgLHROZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Dec 2020 12:14:25 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 01E27FF386
        for <linux-can@vger.kernel.org>; Tue,  8 Dec 2020 17:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.903
X-Spam-Level: 
X-Spam-Status: No, score=-1.903 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, NO_RECEIVED=-0.001,
        NO_RELAYS=-0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nfkRw4WtKly1 for <linux-can@vger.kernel.org>;
        Tue,  8 Dec 2020 18:13:41 +0100 (CET)
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <2a8eb771-6c94-8e3b-2b47-9dc4cf0ea28a@pengutronix.de>
 <8837034e-3a8b-25fd-894c-ffa51d7fe039@ems-wuensche.com>
 <deefcd85-15a8-82e0-9471-b8911a43c676@pengutronix.de>
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: Re: [PATCH 00/17] Add support for CPC-USB/FD CAN FD interface
Message-ID: <3b41cee4-104f-d319-7e25-ef0ad3187105@ems-wuensche.com>
Date:   Tue, 8 Dec 2020 18:13:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <deefcd85-15a8-82e0-9471-b8911a43c676@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

I resent the patch series a while ago. Did I miss something or did I do
something wrong? You immediately commented on the first series, but now
there is silence.

Regards
Gerhard

Am 06.11.20 um 20:59 schrieb Marc Kleine-Budde:
> On 11/6/20 8:04 PM, Gerhard Uttenthaler wrote:
>> Thank you for your instant answers! Would it be OK to resend after
>> rework all the patches again as [PATCH V2 xx/yy]?
> 
> sure
> 
> Marc
> 


-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
