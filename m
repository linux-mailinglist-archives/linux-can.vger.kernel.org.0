Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98846507FC
	for <lists+linux-can@lfdr.de>; Mon, 19 Dec 2022 08:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiLSHOB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Dec 2022 02:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSHOA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Dec 2022 02:14:00 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17C9113F
        for <linux-can@vger.kernel.org>; Sun, 18 Dec 2022 23:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671434039; x=1702970039;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FGrlAeScWJpkZ7950R1X9NI26eVE8CuAYP3OY4mI93s=;
  b=LngSsrZ4NG1+09V0v8ub5EkOeAyfgt7zZ3QirnDnD3uubCH7vbKliWBr
   dVwpXIipIXIjlLVZ9p/sI7WVuNNl9bRyPEB/zbqXnHk7+OGred3i/pm0D
   PasoAk30YTM1Qjc712CFu6iTRSBkqmLJNJp0rakPF/dhrKvfpyXweWg66
   kXrVsueoxf3A3eZksKbHmfvnwblIzTTAFcm+zjw0SlNXbBvGIxOMcBV5q
   Ghff36lWOnsSlY4HoKyO6h88ONQVREyBtuQLxudbNzMAFe8PZvvN99wHj
   +OHrQ4HO7uNY9tS2j8jzr2zkLEZ2BWqDyIppA7CNMt6wYutr5OvWCwWxX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="383630769"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="383630769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 23:13:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="757513502"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="757513502"
Received: from rongch2-mobl3.ccr.corp.intel.com (HELO [10.254.215.132]) ([10.254.215.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 23:13:57 -0800
Message-ID: <490c3e2d-5f84-d045-416e-9138464a58e6@intel.com>
Date:   Mon, 19 Dec 2022 15:13:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [linux-next:master] BUILD REGRESSION
 ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        speakup@linux-speakup.org, linux-can@vger.kernel.org
References: <639c8c39./q+QZSDrWluXOpoJ%lkp@intel.com>
 <20221216155639.wp2t6wqtcfzw3ov2@pengutronix.de>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
In-Reply-To: <20221216155639.wp2t6wqtcfzw3ov2@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12/16/2022 11:56 PM, Marc Kleine-Budde wrote:
> On 16.12.2022 23:18:17, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>> branch HEAD: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291  Add linux-next specific files for 20221216
>>
>> Error/Warning reports:
>>
>> https://lore.kernel.org/oe-kbuild-all/202211180516.dtOWIlEo-lkp@intel.com
>> https://lore.kernel.org/oe-kbuild-all/202211180955.UiXgTkeu-lkp@intel.com
>> https://lore.kernel.org/oe-kbuild-all/202211190207.Rf66o1j0-lkp@intel.com
>> https://lore.kernel.org/oe-kbuild-all/202211242120.MzZVGULn-lkp@intel.com
>> https://lore.kernel.org/oe-kbuild-all/202212020520.0OkMIno3-lkp@intel.com
>> https://lore.kernel.org/oe-kbuild-all/202212051759.cEv6fyHy-lkp@intel.com
>> https://lore.kernel.org/oe-kbuild-all/202212142121.vendKsOc-lkp@intel.com
>>
>> Error/Warning: (recently discovered and may have been fixed)
> I think none of these Errors/Warnings are linux-can related, am I
> missing something?
>
> Marc
>

Hi Marc,

There's a warning related to linux-can:

   Documentation/networking/devlink/etas_es58x.rst: WARNING: document isn't included in any toctree

and here is the report: https://lore.kernel.org/oe-kbuild-all/CAMZ6RqL23hbqNsMk8F8wjN5fEs2wwRBwO++FQu=GEFRQWPO0Dw@mail.gmail.com/

Best Regards,
Rong Chen

